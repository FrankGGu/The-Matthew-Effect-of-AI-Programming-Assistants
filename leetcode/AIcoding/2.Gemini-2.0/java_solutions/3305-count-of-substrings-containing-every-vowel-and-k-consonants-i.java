class Solution {
    public int countVowelSubstrings(String word, int k) {
        int n = word.length();
        int count = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                String sub = word.substring(i, j + 1);
                if (isVowelSubstring(sub, k)) {
                    count++;
                }
            }
        }
        return count;
    }

    private boolean isVowelSubstring(String s, int k) {
        int vowelCount = 0;
        int consonantCount = 0;
        boolean a = false, e = false, i = false, o = false, u = false;
        for (char c : s.toCharArray()) {
            if (c == 'a') {
                a = true;
            } else if (c == 'e') {
                e = true;
            } else if (c == 'i') {
                i = true;
            } else if (c == 'o') {
                o = true;
            } else if (c == 'u') {
                u = true;
            } else {
                consonantCount++;
            }
        }

        if (a && e && i && o && u && consonantCount == k) {
            return true;
        }
        return false;
    }
}