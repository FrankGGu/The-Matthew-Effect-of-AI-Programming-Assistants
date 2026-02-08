class Solution {
    public int maxValueOfCoins(List<List<Integer>> piles, int k) {
        int n = piles.size();
        int[][] dp = new int[n + 1][k + 1];

        for (int i = 1; i <= n; i++) {
            for (int coins = 0; coins <= k; coins++) {
                dp[i][coins] = dp[i - 1][coins];
                int currentSum = 0;
                for (int x = 1; x <= Math.min(coins, piles.get(i - 1).size()); x++) {
                    currentSum += piles.get(i - 1).get(x - 1);
                    dp[i][coins] = Math.max(dp[i][coins], dp[i - 1][coins - x] + currentSum);
                }
            }
        }

        return dp[n][k];
    }
}