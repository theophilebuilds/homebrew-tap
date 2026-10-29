class Byefiles < Formula
  desc "Sort a messy folder with Apple's on-device AI, nothing leaves your Mac"
  homepage "https://github.com/theophilebuilds/byefiles"
  url "https://github.com/theophilebuilds/byefiles/releases/download/v0.1.0/byefiles-0.1.0-arm64.tar.gz"
  sha256 "86722a82a113f1f2af60ae6e591661e5046b4c8d7556c1da7e2fcff68f535c55"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  uses_from_macos "python"

  def install
    # Moteur déjà compilé (le compiler demande Xcode complet, à cause des macros de Foundation Models).
    libexec.install "byefiles.py", "ui.html", "bin"
    (bin/"byefiles").write <<~SH
      #!/bin/bash
      exec /usr/bin/python3 -I "#{libexec}/byefiles.py" "$@"
    SH
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/byefiles --version")
    assert_path_exists libexec/"bin/byefiles-analyze"
  end
end
