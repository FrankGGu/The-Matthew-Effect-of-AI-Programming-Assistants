class Solution {
    public long countSubstrings(String s, char c) {
        long count = 0;
        int n = s.length();
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == c) {
                for (int j = i; j < n; j++) {
                    if (s.charAt(j) == c) {
                        count++;
                    }
                }
            }
        }
        return count;
    }
}