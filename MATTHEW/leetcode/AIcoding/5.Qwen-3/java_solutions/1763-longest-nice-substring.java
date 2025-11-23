public class Solution {
    public String longestNiceSubstring(String s) {
        int n = s.length();
        String result = "";
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j <= n; j++) {
                String sub = s.substring(i, j);
                if (isNice(sub) && sub.length() > result.length()) {
                    result = sub;
                }
            }
        }
        return result;
    }

    private boolean isNice(String s) {
        boolean[] upper = new boolean[26];
        boolean[] lower = new boolean[26];
        for (char c : s.toCharArray()) {
            if (c >= 'A' && c <= 'Z') {
                upper[c - 'A'] = true;
            } else {
                lower[c - 'a'] = true;
            }
        }
        for (int i = 0; i < 26; i++) {
            if (upper[i] && !lower[i]) return false;
            if (lower[i] && !upper[i]) return false;
        }
        return true;
    }
}