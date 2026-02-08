class Solution {
    public int[] getSumAbsoluteDifferences(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
        int[] prefixSum = new int[n];
        prefixSum[0] = nums[0];
        for (int i = 1; i < n; i++) {
            prefixSum[i] = prefixSum[i - 1] + nums[i];
        }

        for (int i = 0; i < n; i++) {
            int leftSum = i > 0 ? prefixSum[i - 1] : 0;
            int rightSum = prefixSum[n - 1] - prefixSum[i];
            int leftCount = i;
            int rightCount = n - 1 - i;

            result[i] = nums[i] * leftCount - leftSum + rightSum - nums[i] * rightCount;
        }

        return result;
    }
}