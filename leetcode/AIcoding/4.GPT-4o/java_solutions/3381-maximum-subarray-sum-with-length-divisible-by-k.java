class Solution {
    public int maxSumDivK(int[] A, int K) {
        int n = A.length;
        int maxSum = 0;
        int[] dp = new int[K];
        dp[0] = 0;

        for (int num : A) {
            int[] newDp = dp.clone();
            for (int r = 0; r < K; r++) {
                int newSum = dp[r] + num;
                newDp[newSum % K] = Math.max(newDp[newSum % K], newSum);
            }
            dp = newDp;
        }

        for (int i = K; i < n + 1; i++) {
            maxSum = Math.max(maxSum, dp[i % K]);
        }
        return maxSum;
    }
}