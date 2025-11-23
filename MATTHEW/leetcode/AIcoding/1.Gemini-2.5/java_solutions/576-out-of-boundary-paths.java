class Solution {
    private int M, N;
    private int[][][] memo;
    private final int MOD = 1_000_000_007;

    public int findPaths(int m, int n, int maxMoves, int startRow, int startColumn) {
        M = m;
        N = n;
        memo = new int[m][n][maxMoves + 1];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                java.util.Arrays.fill(memo[i][j], -1);
            }
        }

        return dfs(startRow, startColumn, maxMoves);
    }

    private int dfs(int r, int c, int moves) {
        if (r < 0 || r >= M || c < 0 || c >= N) {
            return 1; // Path goes out of bounds
        }

        if (moves == 0) {
            return 0; // No moves left, but still in bounds
        }

        if (memo[r][c][moves] != -1) {
            return memo[r][c][moves];
        }

        long count = 0;
        count = (count + dfs(r + 1, c, moves - 1)) % MOD; // Move down
        count = (count + dfs(r - 1, c, moves - 1)) % MOD; // Move up
        count = (count + dfs(r, c + 1, moves - 1)) % MOD; // Move right
        count = (count + dfs(r, c - 1, moves - 1)) % MOD; // Move left

        memo[r][c][moves] = (int) count;
        return (int) count;
    }
}