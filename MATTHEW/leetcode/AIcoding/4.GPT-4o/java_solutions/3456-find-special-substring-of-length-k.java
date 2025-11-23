class Solution {
    public boolean hasAllCharacters(String s, int k) {
        int[] count = new int[26];
        for (int i = 0; i < k; i++) {
            count[s.charAt(i) - 'a']++;
        }
        for (int c : count) {
            if (c == 0) return false;
        }
        return true;
    }

    public int findSpecialSubstring(String s, int k) {
        if (s.length() < k) return 0;
        int result = 0;
        for (int i = 0; i <= s.length() - k; i++) {
            if (hasAllCharacters(s.substring(i, i + k), k)) {
                result++;
            }
        }
        return result;
    }
}