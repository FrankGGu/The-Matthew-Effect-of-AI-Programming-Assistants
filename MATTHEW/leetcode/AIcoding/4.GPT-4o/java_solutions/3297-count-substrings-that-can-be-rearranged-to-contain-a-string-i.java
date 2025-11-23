class Solution {
    public int countSubstrings(String s, String t) {
        int count = 0;
        int m = s.length(), n = t.length();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int diff = 0;
                for (int len = 0; i + len < m && j + len < n; len++) {
                    if (s.charAt(i + len) != t.charAt(j + len)) {
                        diff++;
                    }
                    if (diff == 1) {
                        count++;
                    }
                }
            }
        }
        return count;
    }
}