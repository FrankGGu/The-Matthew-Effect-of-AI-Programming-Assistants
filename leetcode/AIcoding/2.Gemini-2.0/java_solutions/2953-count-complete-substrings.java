class Solution {
    public int countCompleteSubstrings(String word, int k) {
        int n = word.length();
        int count = 0;
        for (int len = k; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                String sub = word.substring(i, i + len);
                if (isComplete(sub, k)) {
                    count++;
                }
            }
        }
        return count;
    }

    private boolean isComplete(String s, int k) {
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }
        int distinctChars = 0;
        for (int i = 0; i < 26; i++) {
            if (freq[i] > 0) {
                distinctChars++;
                if (freq[i] != k) {
                    return false;
                }
            }
        }
        return distinctChars * k == s.length();
    }
}