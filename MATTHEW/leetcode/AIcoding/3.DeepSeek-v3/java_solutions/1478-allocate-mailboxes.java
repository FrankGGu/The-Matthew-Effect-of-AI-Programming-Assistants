class Solution {
    public int minDistance(int[] houses, int k) {
        Arrays.sort(houses);
        int n = houses.length;
        int[][] cost = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                int median = houses[(i + j) / 2];
                for (int m = i; m <= j; m++) {
                    cost[i][j] += Math.abs(houses[m] - median);
                }
            }
        }
        int[][] dp = new int[n][k + 1];
        for (int i = 0; i < n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE / 2);
        }
        for (int i = 0; i < n; i++) {
            dp[i][1] = cost[0][i];
        }
        for (int l = 2; l <= k; l++) {
            for (int j = 0; j < n; j++) {
                for (int i = 0; i < j; i++) {
                    dp[j][l] = Math.min(dp[j][l], dp[i][l - 1] + cost[i + 1][j]);
                }
            }
        }
        return dp[n - 1][k];
    }
}