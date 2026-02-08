class Solution {
    public int minSizeSubarray(int[] nums, int target) {
        int totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        int k = target / totalSum;
        int remaining = target % totalSum;

        if (remaining == 0) {
            return k * nums.length;
        }

        int minLen = Integer.MAX_VALUE;
        int currentSum = 0;
        int left = 0;

        for (int right = 0; right < 2 * nums.length; right++) {
            currentSum += nums[right % nums.length];

            while (currentSum > remaining) {
                currentSum -= nums[left % nums.length];
                left++;
            }

            if (currentSum == remaining) {
                minLen = Math.min(minLen, right - left + 1);
            }
        }

        return minLen == Integer.MAX_VALUE ? -1 : k * nums.length + minLen;
    }
}