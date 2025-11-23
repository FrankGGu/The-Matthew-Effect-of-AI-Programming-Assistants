class Solution {
    public int alternatingSubarray(int[] nums) {
        int maxLen = -1;
        int n = nums.length;

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (nums[j] - nums[j - 1] != ((j - i) % 2 == 1 ? 1 : -1)) {
                    break;
                }
                if (j - i + 1 > maxLen) {
                    maxLen = j - i + 1;
                }
            }
        }

        return maxLen;
    }
}