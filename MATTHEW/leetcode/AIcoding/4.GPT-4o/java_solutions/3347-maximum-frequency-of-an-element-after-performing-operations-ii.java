class Solution {
    public int maxFrequency(int[] nums, int k) {
        Arrays.sort(nums);
        int left = 0, right = 0, total = 0, maxFreq = 0;
        while (right < nums.length) {
            total += nums[right];
            while (nums[right] * (right - left + 1) - total > k) {
                total -= nums[left];
                left++;
            }
            maxFreq = Math.max(maxFreq, right - left + 1);
            right++;
        }
        return maxFreq;
    }
}