class Solution {
    public int waysToEarnPoints(int[] points, int target) {
        int mod = 1000000007;
        int[] dp = new int[target + 1];
        dp[0] = 1;

        for (int point : points) {
            for (int j = point; j <= target; j++) {
                dp[j] = (dp[j] + dp[j - point]) % mod;
            }
        }

        return dp[target];
    }
}