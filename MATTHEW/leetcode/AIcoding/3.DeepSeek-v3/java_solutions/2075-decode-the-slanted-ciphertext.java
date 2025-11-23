class Solution {
    public String decodeCiphertext(String encodedText, int rows) {
        if (encodedText.isEmpty() || rows == 0) {
            return "";
        }
        int n = encodedText.length();
        int cols = n / rows;
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < cols; i++) {
            for (int j = 0; j < rows; j++) {
                int pos = j * cols + (i + j);
                if (pos < n) {
                    sb.append(encodedText.charAt(pos));
                }
            }
        }
        int end = sb.length() - 1;
        while (end >= 0 && sb.charAt(end) == ' ') {
            end--;
        }
        return sb.substring(0, end + 1);
    }
}