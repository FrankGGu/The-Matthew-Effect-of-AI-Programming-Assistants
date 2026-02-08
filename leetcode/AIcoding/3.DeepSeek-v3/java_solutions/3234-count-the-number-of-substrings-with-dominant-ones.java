class Solution {
    public int countSubstrings(String s) {
        int total = 0;
        int n = s.length();
        for (int i = 0; i < n; i++) {
            int count = 0;
            for (int j = i; j < n; j++) {
                if (s.charAt(j) == '1') {
                    count++;
                }
                if (count > (j - i + 1) / 2) {
                    total++;
                }
            }
        }
        return total;
    }
}