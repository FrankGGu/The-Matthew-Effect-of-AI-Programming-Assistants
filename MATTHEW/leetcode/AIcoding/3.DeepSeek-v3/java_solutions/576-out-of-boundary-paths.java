class Solution {
    private final int MOD = 1000000007;
    private int[][][] memo;

    public int findPaths(int m, int n, int maxMove, int startRow, int startColumn) {
        memo = new int[m][n][maxMove + 1];
        for (int[][] matrix : memo) {
            for (int[] row : matrix) {
                Arrays.fill(row, -1);
            }
        }
        return dfs(m, n, maxMove, startRow, startColumn);
    }

    private int dfs(int m, int n, int movesLeft, int i, int j) {
        if (i < 0 || i >= m || j < 0 || j >= n) {
            return 1;
        }
        if (movesLeft == 0) {
            return 0;
        }
        if (memo[i][j][movesLeft] != -1) {
            return memo[i][j][movesLeft];
        }
        int res = 0;
        res = (res + dfs(m, n, movesLeft - 1, i + 1, j)) % MOD;
        res = (res + dfs(m, n, movesLeft - 1, i - 1, j)) % MOD;
        res = (res + dfs(m, n, movesLeft - 1, i, j + 1)) % MOD;
        res = (res + dfs(m, n, movesLeft - 1, i, j - 1)) % MOD;
        memo[i][j][movesLeft] = res;
        return res;
    }
}