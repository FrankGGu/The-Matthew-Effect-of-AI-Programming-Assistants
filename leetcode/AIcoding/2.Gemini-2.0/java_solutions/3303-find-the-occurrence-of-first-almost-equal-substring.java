class Solution {
    public int findFirstAlmostEqual(String s1, String s2, int len) {
        int n = s1.length();
        for (int i = 0; i <= n - len; i++) {
            int diff = 0;
            for (int j = 0; j < len; j++) {
                if (s1.charAt(i + j) != s2.charAt(i + j)) {
                    diff++;
                }
            }
            if (diff <= 1) {
                return i;
            }
        }
        return -1;
    }
}