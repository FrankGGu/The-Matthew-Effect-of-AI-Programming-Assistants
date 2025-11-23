public class Solution {
    public String shortestBeautifulString(String s) {
        int n = s.length();
        for (int len = 1; len <= n; len++) {
            for (int i = 0; i + len <= n; i++) {
                String sub = s.substring(i, i + len);
                if (isBeautiful(sub)) {
                    return sub;
                }
            }
        }
        return "";
    }

    private boolean isBeautiful(String s) {
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }
        for (int i = 0; i < 26; i++) {
            if (count[i] > 1) {
                return false;
            }
        }
        return true;
    }
}