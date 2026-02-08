class Solution {
    public int maxSumWithK(int[] nums, int k) {
        int n = nums.length;
        long maxSum = 0;
        long currentSum = 0;
        int left = 0;

        for (int right = 0; right < n; right++) {
            currentSum += nums[right];

            while (right - left + 1 > k) {
                currentSum -= nums[left];
                left++;
            }

            if (right - left + 1 == k) {
                maxSum = Math.max(maxSum, currentSum);
            }
        }

        return (int)maxSum;
    }
}