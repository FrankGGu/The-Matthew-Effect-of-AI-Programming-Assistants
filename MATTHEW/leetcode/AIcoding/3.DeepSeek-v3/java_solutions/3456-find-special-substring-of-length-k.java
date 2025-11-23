class Solution {
    public String findSpecialSubstring(String s, int k) {
        int n = s.length();
        for (int i = 0; i <= n - k; i++) {
            String substr = s.substring(i, i + k);
            if (isSpecial(substr)) {
                return substr;
            }
        }
        return "";
    }

    private boolean isSpecial(String s) {
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }
        int vowels = 0;
        int consonants = 0;
        for (int i = 0; i < 26; i++) {
            char c = (char) ('a' + i);
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                vowels += count[i];
            } else {
                consonants += count[i];
            }
        }
        return vowels == consonants;
    }
}