class Solution {
    public int canComplete(int[] A, int[] B, int[] C) {
        int n = A.length;
        int[] dp = new int[n + 1];
        for (int i = 0; i < n; i++) {
            dp[i + 1] = Math.max(dp[i], dp[i] + A[i]);
            if (i + 1 >= B[i]) {
                dp[i + 1] = Math.max(dp[i + 1], dp[i + 1 - B[i]] + C[i]);
            }
        }
        return dp[n];
    }
}