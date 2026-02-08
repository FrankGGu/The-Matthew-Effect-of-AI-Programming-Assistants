class Solution {
    public int longestAlternatingSubarray(int[] nums) {
        int maxLength = 1, currentLength = 1;
        boolean isIncreasing = false;

        for (int i = 1; i < nums.length; i++) {
            if (nums[i] > nums[i - 1]) {
                if (isIncreasing) {
                    currentLength++;
                } else {
                    maxLength = Math.max(maxLength, currentLength);
                    currentLength = 2;
                    isIncreasing = true;
                }
            } else if (nums[i] < nums[i - 1]) {
                if (!isIncreasing) {
                    currentLength++;
                } else {
                    maxLength = Math.max(maxLength, currentLength);
                    currentLength = 2;
                    isIncreasing = false;
                }
            } else {
                maxLength = Math.max(maxLength, currentLength);
                currentLength = 1;
            }
        }
        return Math.max(maxLength, currentLength);
    }
}