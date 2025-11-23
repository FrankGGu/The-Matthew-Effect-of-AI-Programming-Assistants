class Solution {
    public int countSubstrings(String s, char c) {
        int count = 0;
        int n = s.length();

        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                if (s.charAt(i) == c && s.charAt(j) == c) {
                    count++;
                }
            }
        }

        return count;
    }
}