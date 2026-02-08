class Solution {
    public int longestSubstring(String s, int k) {
        return helper(s.toCharArray(), 0, s.length(), k);
    }

    private int helper(char[] chars, int left, int right, int k) {
        if (right - left < k) return 0;
        int[] count = new int[26];
        for (int i = left; i < right; i++) {
            count[chars[i] - 'a']++;
        }
        for (int i = left; i < right; i++) {
            if (count[chars[i] - 'a'] < k) {
                int j = i + 1;
                while (j < right && count[chars[j] - 'a'] < k) j++;
                return Math.max(helper(chars, left, i, k), helper(chars, j, right, k));
            }
        }
        return right - left;
    }
}