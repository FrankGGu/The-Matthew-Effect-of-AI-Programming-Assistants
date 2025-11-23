class Solution {
    public int longestAlternatingSubarray(int[] nums, int threshold) {
        int maxLen = 0;
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] > threshold) {
                continue;
            }
            if (nums[i] % 2 == 0) {
                int currLen = 1;
                int prev = nums[i] % 2;
                for (int j = i + 1; j < nums.length; j++) {
                    if (nums[j] > threshold) {
                        break;
                    }
                    if (nums[j] % 2 != prev) {
                        currLen++;
                        prev = nums[j] % 2;
                    } else {
                        break;
                    }
                }
                maxLen = Math.max(maxLen, currLen);
            }
        }
        return maxLen;
    }
}