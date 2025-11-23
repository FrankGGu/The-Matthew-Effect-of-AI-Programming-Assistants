import java.util.List;

class Solution {
    public int maxCoins(List<List<Integer>> piles, int k) {
        int n = piles.size();
        int[][] dp = new int[n + 1][k + 1];

        for (int i = n - 1; i >= 0; i--) {
            for (int j = 0; j <= k; j++) {
                dp[i][j] = dp[i + 1][j];
                int currentSum = 0;
                for (int x = 0; x < Math.min(piles.get(i).size(), j); x++) {
                    currentSum += piles.get(i).get(x);
                    dp[i][j] = Math.max(dp[i][j], currentSum + dp[i + 1][j - x - 1]);
                }
            }
        }

        return dp[0][k];
    }
}