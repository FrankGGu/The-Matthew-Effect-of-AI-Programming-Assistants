class Solution {
    public int maximumSum(int[] arr) {
        int n = arr.length;
        int[] dp0 = new int[n];
        int[] dp1 = new int[n];
        int maxSum = arr[0];
        dp0[0] = arr[0];
        dp1[0] = 0;

        for (int i = 1; i < n; i++) {
            dp0[i] = Math.max(arr[i], dp0[i - 1] + arr[i]);
            dp1[i] = Math.max(dp0[i - 1], dp1[i - 1] + arr[i]);
            maxSum = Math.max(maxSum, Math.max(dp0[i], dp1[i]));
        }
        return maxSum;
    }
}