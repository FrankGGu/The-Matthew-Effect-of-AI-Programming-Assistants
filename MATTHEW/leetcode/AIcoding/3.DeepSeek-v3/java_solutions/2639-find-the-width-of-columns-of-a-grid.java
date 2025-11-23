class Solution {
    public int[] findColumnWidth(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int[] res = new int[cols];

        for (int j = 0; j < cols; j++) {
            int maxWidth = 0;
            for (int i = 0; i < rows; i++) {
                int num = grid[i][j];
                int length = String.valueOf(num).length();
                if (length > maxWidth) {
                    maxWidth = length;
                }
            }
            res[j] = maxWidth;
        }

        return res;
    }
}