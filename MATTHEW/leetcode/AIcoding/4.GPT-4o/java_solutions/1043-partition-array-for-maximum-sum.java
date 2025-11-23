class Solution {
    public int maxSumAfterPartitioning(int[] A, int K) {
        int n = A.length;
        int[] dp = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            int maxVal = 0;
            for (int k = 1; k <= Math.min(K, i); k++) {
                maxVal = Math.max(maxVal, A[i - k]);
                dp[i] = Math.max(dp[i], dp[i - k] + maxVal * k);
            }
        }
        return dp[n];
    }
}