class Solution {
    public int[] getSumAbsoluteDifferences(int[] nums) {
        int n = nums.length;
        int[] prefixSum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            int leftSum = nums[i] * i - prefixSum[i];
            int rightSum = prefixSum[n] - prefixSum[i + 1] - nums[i] * (n - 1 - i);
            result[i] = leftSum + rightSum;
        }
        return result;
    }
}