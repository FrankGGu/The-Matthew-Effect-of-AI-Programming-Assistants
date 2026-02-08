class Solution {
    public boolean canDivideIntoSubsequences(int[] nums, int k) {
        int maxFreq = 1;
        int currentFreq = 1;

        for (int i = 1; i < nums.length; i++) {
            if (nums[i] == nums[i - 1]) {
                currentFreq++;
                maxFreq = Math.max(maxFreq, currentFreq);
            } else {
                currentFreq = 1;
            }
        }

        return nums.length >= maxFreq * k;
    }
}