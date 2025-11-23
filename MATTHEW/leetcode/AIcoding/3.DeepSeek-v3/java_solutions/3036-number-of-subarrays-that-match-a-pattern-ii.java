class Solution {
    public int countMatchingSubarrays(int[] nums, int[] pattern) {
        int n = nums.length;
        int m = pattern.length;
        if (n <= m) return 0;

        int[] text = new int[n - 1];
        for (int i = 0; i < n - 1; i++) {
            if (nums[i + 1] > nums[i]) {
                text[i] = 1;
            } else if (nums[i + 1] == nums[i]) {
                text[i] = 0;
            } else {
                text[i] = -1;
            }
        }

        int[] lps = computeLPS(pattern);
        int i = 0;
        int j = 0;
        int count = 0;
        while (i < text.length) {
            if (text[i] == pattern[j]) {
                i++;
                j++;
                if (j == pattern.length) {
                    count++;
                    j = lps[j - 1];
                }
            } else {
                if (j != 0) {
                    j = lps[j - 1];
                } else {
                    i++;
                }
            }
        }
        return count;
    }

    private int[] computeLPS(int[] pattern) {
        int[] lps = new int[pattern.length];
        int len = 0;
        int i = 1;
        while (i < pattern.length) {
            if (pattern[i] == pattern[len]) {
                len++;
                lps[i] = len;
                i++;
            } else {
                if (len != 0) {
                    len = lps[len - 1];
                } else {
                    lps[i] = 0;
                    i++;
                }
            }
        }
        return lps;
    }
}