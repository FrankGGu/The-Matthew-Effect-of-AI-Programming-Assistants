class Solution {
    public int kConcatenationMaxSum(int[] arr, int k) {
        long mod = 1_000_000_007;
        long sum = 0, maxEnd = 0, maxSum = 0;

        for (int num : arr) {
            sum = (sum + num) % mod;
            maxEnd = (maxEnd + num) % mod;
            maxEnd = Math.max(maxEnd, num);
            maxSum = Math.max(maxSum, maxEnd);
        }

        if (k == 1) {
            return (int) maxSum;
        }

        long totalSum = sum;
        if (totalSum > 0) {
            maxSum = Math.max(maxSum, (maxEnd + (k - 2) * totalSum) % mod);
        }

        return (int) maxSum;
    }
}