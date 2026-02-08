class Solution {
    public int longestEvenOddSubarray(int[] nums, int threshold) {
        int maxLen = 0;
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] <= threshold && nums[i] % 2 == 0) {
                int currentLen = 1;
                for (int j = i + 1; j < nums.length; j++) {
                    if (nums[j] <= threshold && nums[j] % 2 != nums[j - 1] % 2) {
                        currentLen++;
                    } else {
                        break;
                    }
                }
                maxLen = Math.max(maxLen, currentLen);
            }
        }
        return maxLen;
    }
}