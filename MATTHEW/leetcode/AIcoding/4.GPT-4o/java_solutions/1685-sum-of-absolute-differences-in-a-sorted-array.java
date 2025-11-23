class Solution {
    public int[] getSumAbsoluteDifferences(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
        long[] prefixSum = new long[n + 1];

        for (int i = 1; i <= n; i++) {
            prefixSum[i] = prefixSum[i - 1] + nums[i - 1];
        }

        for (int i = 0; i < n; i++) {
            result[i] = (int) (nums[i] * i - prefixSum[i] + (prefixSum[n] - prefixSum[i + 1]) - nums[i] * (n - 1 - i));
        }

        return result;
    }
}