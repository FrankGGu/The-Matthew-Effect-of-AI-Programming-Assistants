class Solution {
    public int longestSubarray(int[] nums) {
        int left = 0, right = 0, zeroCount = 0, maxLen = 0;
        while (right < nums.length) {
            if (nums[right] == 0) {
                zeroCount++;
            }
            while (zeroCount > 1) {
                if (nums[left] == 0) {
                    zeroCount--;
                }
                left++;
            }
            maxLen = Math.max(maxLen, right - left);
            right++;
        }
        if (maxLen == nums.length) return maxLen -1;
        return maxLen;
    }
}