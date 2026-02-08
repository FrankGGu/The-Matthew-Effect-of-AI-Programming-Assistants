class Solution {
    public int alternatingSubarray(int[] nums) {
        int maxLen = -1;
        for (int i = 0; i < nums.length; i++) {
            for (int j = i + 1; j < nums.length; j++) {
                int len = j - i + 1;
                boolean alternating = true;
                for (int k = i; k < j; k++) {
                    if (nums[k + 1] - nums[k] != (k - i) % 2 == 0 ? 1 : -1) {
                        alternating = false;
                        break;
                    }
                }
                if (alternating) {
                    maxLen = Math.max(maxLen, len);
                }
            }
        }
        return maxLen;
    }
}