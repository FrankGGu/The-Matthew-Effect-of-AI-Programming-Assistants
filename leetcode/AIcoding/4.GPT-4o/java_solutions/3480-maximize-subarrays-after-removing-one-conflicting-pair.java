class Solution {
    public long maximumSubarraySum(int[] nums, int k) {
        int n = nums.length;
        long maxSum = 0;
        long currentSum = 0;
        int[] count = new int[100001];

        for (int i = 0; i < n; i++) {
            currentSum += nums[i];
            count[nums[i]]++;

            if (i >= k) {
                currentSum -= nums[i - k];
                count[nums[i - k]]--;
            }

            if (i >= k - 1 && isValid(count)) {
                maxSum = Math.max(maxSum, currentSum);
            }
        }

        return maxSum;
    }

    private boolean isValid(int[] count) {
        for (int c : count) {
            if (c > 1) return false;
        }
        return true;
    }
}