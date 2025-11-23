class Solution {
    public String decodeCiphertext(String encodedText, int rows) {
        int n = encodedText.length();
        int cols = n / rows;
        StringBuilder decodedMessage = new StringBuilder();

        for (int c_start = 0; c_start < cols; c_start++) {
            for (int r = 0; r < rows; r++) {
                int c = c_start + r;
                if (c < cols) {
                    decodedMessage.append(encodedText.charAt(r * cols + c));
                } else {
                    break;
                }
            }
        }

        int i = decodedMessage.length() - 1;
        while (i >= 0 && decodedMessage.charAt(i) == ' ') {
            i--;
        }
        return decodedMessage.substring(0, i + 1);
    }
}