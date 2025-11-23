class Solution {
    public String decodeCiphertext(String encodedText, int rows) {
        int len = encodedText.length();
        int cols = len / rows;
        if (rows > len || cols == 0) return "";
        StringBuilder decodedText = new StringBuilder();
        for (int i = 0; i < cols; i++) {
            int row = 0;
            int col = i;
            while (row < rows && col < cols) {
                decodedText.append(encodedText.charAt(row * cols + col));
                row++;
                col++;
            }
        }
        while (decodedText.length() > 0 && decodedText.charAt(decodedText.length() - 1) == ' ') {
            decodedText.deleteCharAt(decodedText.length() - 1);
        }
        return decodedText.toString();
    }
}