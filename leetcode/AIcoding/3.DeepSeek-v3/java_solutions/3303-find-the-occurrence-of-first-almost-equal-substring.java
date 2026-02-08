class Solution {
    public int findFirstAlmostEqual(String s, String t, int k) {
        int m = s.length();
        int n = t.length();

        for (int i = 0; i <= m - n; i++) {
            boolean found = true;
            for (int j = 0; j < n; j++) {
                if (Math.abs(s.charAt(i + j) - t.charAt(j)) > k) {
                    found = false;
                    break;
                }
            }
            if (found) {
                return i;
            }
        }
        return -1;
    }
}