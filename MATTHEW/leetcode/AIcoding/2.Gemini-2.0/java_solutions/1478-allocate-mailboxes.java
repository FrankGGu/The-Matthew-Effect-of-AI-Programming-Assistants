import java.util.Arrays;

class Solution {
    public int minDistance(int[] houses, int k) {
        Arrays.sort(houses);
        int n = houses.length;
        int[][] cost = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                int median = houses[(i + j) / 2];
                for (int l = i; l <= j; l++) {
                    cost[i][j] += Math.abs(houses[l] - median);
                }
            }
        }

        int[][] dp = new int[n][k + 1];
        for (int i = 0; i < n; i++) {
            dp[i][1] = cost[0][i];
        }

        for (int j = 2; j <= k; j++) {
            for (int i = j - 1; i < n; i++) {
                dp[i][j] = Integer.MAX_VALUE;
                for (int l = j - 2; l < i; l++) {
                    dp[i][j] = Math.min(dp[i][j], dp[l][j - 1] + cost[l + 1][i]);
                }
            }
        }

        return dp[n - 1][k];
    }
}