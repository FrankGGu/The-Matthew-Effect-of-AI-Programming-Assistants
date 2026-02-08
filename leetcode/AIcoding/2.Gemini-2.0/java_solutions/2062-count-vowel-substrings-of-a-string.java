class Solution {
    public int countVowelSubstrings(String word) {
        int count = 0;
        for (int i = 0; i < word.length(); i++) {
            for (int j = i; j < word.length(); j++) {
                String sub = word.substring(i, j + 1);
                if (isVowelSubstring(sub)) {
                    count++;
                }
            }
        }
        return count;
    }

    private boolean isVowelSubstring(String s) {
        if (s.length() == 0) return false;
        for (char c : s.toCharArray()) {
            if (!isVowel(c)) {
                return false;
            }
        }
        boolean a = false, e = false, i = false, o = false, u = false;
        for (char c : s.toCharArray()) {
            if (c == 'a') a = true;
            if (c == 'e') e = true;
            if (c == 'i') i = true;
            if (c == 'o') o = true;
            if (c == 'u') u = true;
        }
        return a && e && i && o && u;
    }

    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }
}