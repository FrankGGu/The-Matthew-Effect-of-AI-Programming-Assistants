class Solution {
    public int longestVShapedDiagonal(int[][] matrix) {
        int rows = matrix.length;
        if (rows == 0) return 0;
        int cols = matrix[0].length;
        int maxLength = 0;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                int length = 1;
                int x = i, y = j;

                // Move down-left
                while (x + 1 < rows && y - 1 >= 0 && matrix[x + 1][y - 1] < matrix[x][y]) {
                    length++;
                    x++;
                    y--;
                }

                x = i; 
                y = j;

                // Move down-right
                while (x + 1 < rows && y + 1 < cols && matrix[x + 1][y + 1] < matrix[x][y]) {
                    length++;
                    x++;
                    y++;
                }

                maxLength = Math.max(maxLength, length);
            }
        }

        return maxLength;
    }
}