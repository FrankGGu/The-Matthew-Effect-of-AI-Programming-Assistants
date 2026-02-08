class Solution {
    public int countSubstrings(String s, String t) {
        int n = s.length();
        int m = t.length();
        int count = 0;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                int diff = 0;
                for (int k = 0; i + k < n && j + k < m; k++) {
                    if (s.charAt(i + k) != t.charAt(j + k)) {
                        diff++;
                    }
                    if (diff == 1) {
                        count++;
                    }
                    if (diff > 1) {
                        break;
                    }
                }
            }
        }
        return count;
    }
}