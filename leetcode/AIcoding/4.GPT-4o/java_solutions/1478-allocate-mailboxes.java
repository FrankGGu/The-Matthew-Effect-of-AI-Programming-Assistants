import java.util.Arrays;

class Solution {
    public int minDistance(int[] houses, int m) {
        Arrays.sort(houses);
        int n = houses.length;
        int[][] dp = new int[n + 1][m + 1];
        for (int[] row : dp) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }
        dp[0][0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= Math.min(i, m); j++) {
                for (int k = 0; k < i; k++) {
                    int cost = calculateCost(houses, k, i - 1);
                    dp[i][j] = Math.min(dp[i][j], dp[k][j - 1] + cost);
                }
            }
        }
        return dp[n][m];
    }

    private int calculateCost(int[] houses, int left, int right) {
        int mid = houses[left + (right - left) / 2];
        int cost = 0;
        for (int i = left; i <= right; i++) {
            cost += Math.abs(houses[i] - mid);
        }
        return cost;
    }
}