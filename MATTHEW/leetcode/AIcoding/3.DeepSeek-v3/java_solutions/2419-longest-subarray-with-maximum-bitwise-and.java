class Solution {
    public int longestSubarray(int[] nums) {
        int maxAnd = 0;
        for (int num : nums) {
            maxAnd = Math.max(maxAnd, num);
        }

        int maxLength = 0;
        int currentLength = 0;
        for (int num : nums) {
            if (num == maxAnd) {
                currentLength++;
                maxLength = Math.max(maxLength, currentLength);
            } else {
                currentLength = 0;
            }
        }
        return maxLength;
    }
}