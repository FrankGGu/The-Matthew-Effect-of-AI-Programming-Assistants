class Solution {
    public long xSum(int[] arr, int k) {
        int n = arr.length;
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + arr[i];
        }
        long result = 0;
        for (int i = 0; i <= n - k; i++) {
            result += prefixSum[i + k] - prefixSum[i];
        }
        return result;
    }
}