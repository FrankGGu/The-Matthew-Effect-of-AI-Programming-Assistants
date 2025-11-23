class Solution {
    public int countSubarrays(int[] nums, int[] pattern) {
        int count = 0;
        int m = pattern.length;
        int n = nums.length;

        for (int i = 0; i <= n - m; i++) {
            boolean match = true;
            for (int j = 0; j < m; j++) {
                if (nums[i + j] != pattern[j]) {
                    match = false;
                    break;
                }
            }
            if (match) {
                count++;
            }
        }
        return count;
    }
}