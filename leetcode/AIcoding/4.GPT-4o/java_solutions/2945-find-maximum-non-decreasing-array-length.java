class Solution {
    public int longestNonDecreasingArray(int[] nums) {
        int maxLength = 1, currentLength = 1;

        for (int i = 1; i < nums.length; i++) {
            if (nums[i] >= nums[i - 1]) {
                currentLength++;
            } else {
                maxLength = Math.max(maxLength, currentLength);
                currentLength = 1;
            }
        }

        return Math.max(maxLength, currentLength);
    }
}