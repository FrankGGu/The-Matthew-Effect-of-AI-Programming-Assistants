class Solution {
    private static final int MOD = 1000000007;

    public int ways(String[] pizza, int k) {
        int m = pizza.length;
        int n = pizza[0].length();
        int[][] apples = new int[m + 1][n + 1];

        for (int i = m - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                apples[i][j] = apples[i + 1][j] + apples[i][j + 1] - apples[i + 1][j + 1] + (pizza[i].charAt(j) == 'A' ? 1 : 0);
            }
        }

        Integer[][][] dp = new Integer[k][m][n];
        return solve(pizza, k - 1, 0, 0, apples, dp);
    }

    private int solve(String[] pizza, int cuts, int row, int col, int[][] apples, Integer[][][] dp) {
        int m = pizza.length;
        int n = pizza[0].length();

        if (apples[row][col] == 0) {
            return 0;
        }

        if (cuts == 0) {
            return 1;
        }

        if (dp[cuts][row][col] != null) {
            return dp[cuts][row][col];
        }

        int ans = 0;
        for (int i = row + 1; i < m; i++) {
            if (apples[row][col] - apples[i][col] > 0) {
                ans = (ans + solve(pizza, cuts - 1, i, col, apples, dp)) % MOD;
            }
        }

        for (int j = col + 1; j < n; j++) {
            if (apples[row][col] - apples[row][j] > 0) {
                ans = (ans + solve(pizza, cuts - 1, row, j, apples, dp)) % MOD;
            }
        }

        return dp[cuts][row][col] = ans;
    }
}