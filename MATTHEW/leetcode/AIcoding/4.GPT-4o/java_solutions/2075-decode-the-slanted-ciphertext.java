class Solution {
    public String decodeCiphertext(String ciphertext, int rows) {
        if (rows == 0) return "";
        int n = ciphertext.length();
        int cols = n / rows;
        StringBuilder result = new StringBuilder();

        for (int col = 0; col < cols; col++) {
            for (int row = 0; row < rows; row++) {
                int index = row + col;
                if (index < cols && index * rows + col < n) {
                    result.append(ciphertext.charAt(index * rows + col));
                }
            }
        }

        while (result.length() > 0 && result.charAt(result.length() - 1) == ' ') {
            result.setLength(result.length() - 1);
        }

        return result.toString();
    }
}