class Solution {
    public int minOperations(int[] nums, int x) {
        int total = 0, target = 0;
        for (int num : nums) {
            total += num;
        }
        target = total - x;
        if (target < 0) return -1;

        int left = 0, right = 0, maxLen = -1, currentSum = 0;

        while (right < nums.length) {
            currentSum += nums[right];
            while (currentSum > target && left <= right) {
                currentSum -= nums[left++];
            }
            if (currentSum == target) {
                maxLen = Math.max(maxLen, right - left + 1);
            }
            right++;
        }

        return maxLen == -1 ? -1 : nums.length - maxLen;
    }
}