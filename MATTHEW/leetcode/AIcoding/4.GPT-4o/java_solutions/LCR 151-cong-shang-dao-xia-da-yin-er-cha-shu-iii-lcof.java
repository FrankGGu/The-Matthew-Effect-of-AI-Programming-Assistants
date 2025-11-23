class Solution {
    public int longestAlternatingSubarray(int[] nums) {
        int maxLength = 0;
        int currentLength = 0;

        for (int i = 1; i < nums.length; i++) {
            if ((nums[i] % 2) != (nums[i - 1] % 2)) {
                currentLength++;
            } else {
                currentLength = 1;
            }
            maxLength = Math.max(maxLength, currentLength + 1);
        }

        return maxLength;
    }
}