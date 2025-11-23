class Solution {
    public int minOperations(int[] nums, int x) {
        int total = Arrays.stream(nums).sum();
        int target = total - x;
        if (target < 0) return -1;

        int maxLength = -1, currentSum = 0;
        for (int left = 0, right = 0; right < nums.length; right++) {
            currentSum += nums[right];
            while (currentSum > target && left <= right) {
                currentSum -= nums[left++];
            }
            if (currentSum == target) {
                maxLength = Math.max(maxLength, right - left + 1);
            }
        }
        return maxLength == -1 ? -1 : nums.length - maxLength;
    }
}