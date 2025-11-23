class Solution {
    public long minOperationsToMakeMedianK(int[] nums, int k) {
        Arrays.sort(nums);
        int n = nums.length;
        int medianPos = n / 2;
        long operations = 0;

        if (nums[medianPos] == k) {
            return 0;
        } else if (nums[medianPos] < k) {
            for (int i = medianPos; i < n && nums[i] < k; i++) {
                operations += k - nums[i];
            }
        } else {
            for (int i = medianPos; i >= 0 && nums[i] > k; i--) {
                operations += nums[i] - k;
            }
        }

        return operations;
    }
}