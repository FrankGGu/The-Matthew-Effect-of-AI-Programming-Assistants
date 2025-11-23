class Solution {
    public int maxValueOfCoins(List<List<Integer>> piles, int k) {
        int n = piles.size();
        int[][] dp = new int[n + 1][k + 1];

        for (int i = 1; i <= n; i++) {
            List<Integer> pile = piles.get(i - 1);
            for (int j = 0; j <= k; j++) {
                int sum = 0;
                dp[i][j] = dp[i - 1][j];
                for (int l = 1; l <= Math.min(j, pile.size()); l++) {
                    sum += pile.get(l - 1);
                    dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - l] + sum);
                }
            }
        }

        return dp[n][k];
    }
}