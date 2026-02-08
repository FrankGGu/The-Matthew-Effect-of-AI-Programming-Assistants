class Solution {
    public int maximumSum(int[] arr) {
        int n = arr.length;
        int[] dp = new int[n];
        dp[0] = arr[0];
        int maxSum = arr[0];
        int maxWithDeletion = 0;

        for (int i = 1; i < n; i++) {
            dp[i] = Math.max(arr[i], dp[i - 1] + arr[i]);
            maxSum = Math.max(maxSum, dp[i]);
            maxWithDeletion = Math.max(maxWithDeletion + arr[i], dp[i - 1]);
        }

        return Math.max(maxSum, maxWithDeletion);
    }
}