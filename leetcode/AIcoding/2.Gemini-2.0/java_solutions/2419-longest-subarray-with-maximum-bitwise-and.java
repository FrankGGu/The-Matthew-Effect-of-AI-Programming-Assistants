class Solution {
    public int longestSubarray(int[] nums) {
        int maxVal = 0;
        for (int num : nums) {
            maxVal = Math.max(maxVal, num);
        }
        int count = 0;
        int maxLen = 0;
        for (int num : nums) {
            if (num == maxVal) {
                count++;
                maxLen = Math.max(maxLen, count);
            } else {
                count = 0;
            }
        }
        return maxLen;
    }
}