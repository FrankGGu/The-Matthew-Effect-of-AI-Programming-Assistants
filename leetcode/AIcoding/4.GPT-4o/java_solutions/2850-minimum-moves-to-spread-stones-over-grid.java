class Solution {
    public int minimumMoves(int[][] grid) {
        int n = grid.length, m = grid[0].length;
        int totalStones = 0;
        for (int[] row : grid) {
            for (int stone : row) {
                totalStones += stone;
            }
        }

        int target = totalStones / (n * m);
        int moves = 0;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                moves += Math.abs(grid[i][j] - target);
            }
        }

        return moves / 2;
    }
}