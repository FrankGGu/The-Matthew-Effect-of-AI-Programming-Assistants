class Solution {
    public int findUnsortedSubarray(int[] nums) {
        int n = nums.length;
        int left = 0, right = n - 1;
        while (left < n - 1 && nums[left] <= nums[left + 1]) {
            left++;
        }
        if (left == n - 1) {
            return 0;
        }
        while (right > 0 && nums[right] >= nums[right - 1]) {
            right--;
        }
        int minVal = Integer.MAX_VALUE, maxVal = Integer.MIN_VALUE;
        for (int i = left; i <= right; i++) {
            minVal = Math.min(minVal, nums[i]);
            maxVal = Math.max(maxVal, nums[i]);
        }
        while (left > 0 && nums[left - 1] > minVal) {
            left--;
        }
        while (right < n - 1 && nums[right + 1] < maxVal) {
            right++;
        }
        return right - left + 1;
    }
}