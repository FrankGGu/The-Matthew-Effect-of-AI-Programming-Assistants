class Solution {
    public int countCombinations(int n, int k) {
        int[][] dp = new int[k + 1][n + 1];
        dp[0][0] = 1;

        for (int moves = 1; moves <= k; moves++) {
            for (int pos = 0; pos <= n; pos++) {
                for (int step = -1; step <= 1; step++) {
                    if (pos + step >= 0 && pos + step <= n) {
                        dp[moves][pos] += dp[moves - 1][pos + step];
                    }
                }
            }
        }

        int totalCombinations = 0;
        for (int pos = 0; pos <= n; pos++) {
            totalCombinations += dp[k][pos];
        }

        return totalCombinations;
    }
}