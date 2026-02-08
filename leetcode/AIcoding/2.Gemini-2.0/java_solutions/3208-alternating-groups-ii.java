class Solution {
    public int alternatingSubarray(int[] nums) {
        int maxLength = -1;
        for (int i = 0; i < nums.length; i++) {
            for (int j = i + 1; j < nums.length; j++) {
                int len = j - i + 1;
                boolean valid = true;
                for (int k = i; k < j; k++) {
                    if (nums[k + 1] - nums[k] != (k - i) % 2 == 0 ? 1 : -1) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    maxLength = Math.max(maxLength, len);
                }
            }
        }
        return maxLength;
    }
}