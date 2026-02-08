class Solution {
    public int longestSubstring(String s, int k) {
        if (s == null || s.length() == 0) {
            return 0;
        }
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }
        for (int i = 0; i < 26; i++) {
            if (count[i] > 0 && count[i] < k) {
                char c = (char) (i + 'a');
                String[] parts = s.split(String.valueOf(c));
                int maxLen = 0;
                for (String part : parts) {
                    maxLen = Math.max(maxLen, longestSubstring(part, k));
                }
                return maxLen;
            }
        }
        return s.length();
    }
}