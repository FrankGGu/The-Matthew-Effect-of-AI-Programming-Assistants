class Solution {
    public int longestAlternatingSubarray(int[] nums) {
        int maxLength = 0;
        int currentLength = 0;

        for (int i = 0; i < nums.length; i++) {
            if (i == 0 || nums[i] * nums[i - 1] < 0) {
                currentLength++;
            } else {
                currentLength = 1;
            }
            maxLength = Math.max(maxLength, currentLength);
        }

        return maxLength;
    }
}