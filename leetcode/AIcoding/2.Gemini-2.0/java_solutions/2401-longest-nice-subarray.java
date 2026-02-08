class Solution {
    public int longestNiceSubarray(int[] nums) {
        int left = 0;
        int currentXor = 0;
        int maxLength = 0;
        for (int right = 0; right < nums.length; right++) {
            while ((currentXor & nums[right]) != 0) {
                currentXor ^= nums[left];
                left++;
            }
            currentXor ^= nums[right];
            maxLength = Math.max(maxLength, right - left + 1);
        }
        return maxLength;
    }
}