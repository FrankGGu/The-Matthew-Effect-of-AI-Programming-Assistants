class Solution {
    public long[] sumOfKxP(int[] nums, int k, int x, int p) {
        int n = nums.length;
        long[] result = new long[n - k + 1];
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = (prefixSum[i] + nums[i]) % p;
        }
        for (int i = 0; i <= n - k; i++) {
            long sum = (prefixSum[i + k] - prefixSum[i] + p) % p;
            result[i] = (long) Math.pow(sum, x);
        }
        return result;
    }
}