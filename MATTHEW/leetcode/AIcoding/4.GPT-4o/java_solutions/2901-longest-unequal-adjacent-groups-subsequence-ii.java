class Solution {
    public int longestUnequalAdjacentGroups(int[] nums) {
        int n = nums.length;
        if (n == 0) return 0;

        int maxLength = 1;
        int currentLength = 1;

        for (int i = 1; i < n; i++) {
            if (nums[i] != nums[i - 1]) {
                currentLength++;
            } else {
                maxLength = Math.max(maxLength, currentLength);
                currentLength = 1;
            }
        }

        maxLength = Math.max(maxLength, currentLength);
        return maxLength;
    }
}