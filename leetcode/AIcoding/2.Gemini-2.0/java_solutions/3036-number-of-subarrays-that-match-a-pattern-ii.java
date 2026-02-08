class Solution {
    public int countMatchingSubarrays(int[] nums, int[] pattern) {
        int n = nums.length;
        int m = pattern.length;
        int[] s = new int[n - 1];
        for (int i = 0; i < n - 1; i++) {
            if (nums[i + 1] > nums[i]) {
                s[i] = 1;
            } else if (nums[i + 1] < nums[i]) {
                s[i] = -1;
            } else {
                s[i] = 0;
            }
        }

        int count = 0;
        for (int i = 0; i <= n - 1 - m; i++) {
            boolean match = true;
            for (int j = 0; j < m; j++) {
                if (i + j >= s.length || s[i + j] != pattern[j]) {
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