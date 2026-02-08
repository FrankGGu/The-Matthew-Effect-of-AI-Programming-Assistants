class Solution {
    public int getSumAbsoluteDifferences(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        int leftSum = 0;
        for (int i = 0; i < n; i++) {
            int rightSum = sum - leftSum - nums[i];
            result[i] = nums[i] * i - leftSum + rightSum - nums[i] * (n - 1 - i);
            leftSum += nums[i];
        }
        return result;
    }
}