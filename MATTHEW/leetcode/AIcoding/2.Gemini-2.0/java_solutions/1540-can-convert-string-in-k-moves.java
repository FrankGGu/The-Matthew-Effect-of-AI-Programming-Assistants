class Solution {
    public boolean canConvertString(String s, String t, int k) {
        if (s.length() != t.length()) {
            return false;
        }

        int n = s.length();
        int[] diffCount = new int[26];

        for (int i = 0; i < n; i++) {
            int diff = (t.charAt(i) - s.charAt(i) + 26) % 26;
            if (diff > 0) {
                diffCount[diff % 26]++;
            }
        }

        for (int i = 1; i < 26; i++) {
            if (diffCount[i] > (k / 26 + (k % 26 >= i ? 1 : 0))) {
                return false;
            }
        }

        return true;
    }
}