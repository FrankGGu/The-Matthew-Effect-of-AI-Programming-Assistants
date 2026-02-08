class Solution {
    public int countServers(int[][] grid) {
        int rows = grid.length;
        if (rows == 0) {
            return 0;
        }
        int cols = grid[0].length;
        if (cols == 0) {
            return 0;
        }

        int[] rowCounts = new int[rows];
        int[] colCounts = new int[cols];

        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                if (grid[r][c] == 1) {
                    rowCounts[r]++;
                    colCounts[c]++;
                }
            }
        }

        int communicatingServers = 0;
        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                if (grid[r][c] == 1) {
                    if (rowCounts[r] > 1 || colCounts[c] > 1) {
                        communicatingServers++;
                    }
                }
            }
        }

        return communicatingServers;
    }
}