class Solution {
    public int minOperations(String s1, String s2) {
        int n = s1.length();
        int diff = 0;
        for (int i = 0; i < n; i++) {
            if (s1.charAt(i) != s2.charAt(i)) {
                diff++;
            }
        }
        if (diff % 2 != 0) {
            return -1;
        }

        int count = 0;
        int ones = 0;
        for (int i = 0; i < n; i++) {
            if (s1.charAt(i) != s2.charAt(i)) {
                if (s1.charAt(i) == '1') {
                    ones++;
                }
            }
        }
        return ones % 2 == 0 ? diff / 2 : diff / 2 + 1;
    }
}