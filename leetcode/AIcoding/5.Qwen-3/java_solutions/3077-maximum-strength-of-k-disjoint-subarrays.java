public class Solution {
    public int maxSumAfterPartitioning(int[] arr, int k) {
        int n = arr.length;
        int[] dp = new int[n];

        for (int i = 0; i < n; i++) {
            int maxVal = 0;
            for (int j = i; j >= Math.max(0, i - k + 1); j--) {
                maxVal = Math.max(maxVal, arr[j]);
                dp[i] = Math.max(dp[i], dp[j - 1] + maxVal * (i - j + 1));
            }
        }

        return dp[n - 1];
    }
}