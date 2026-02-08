class Solution {
    public int[] findColumnWidth(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        int[] result = new int[n];

        for (int c = 0; c < n; c++) {
            int maxWidth = 0;
            for (int r = 0; r < m; r++) {
                int num = grid[r][c];
                String s = String.valueOf(num);
                maxWidth = Math.max(maxWidth, s.length());
            }
            result[c] = maxWidth;
        }

        return result;
    }
}