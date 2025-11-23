class Solution {
    private static final int MOD = 1_000_000_007;

    public int countSubstrings(String s, String t) {
        int m = s.length();
        int n = t.length();
        int res = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int diff = 0;
                for (int k = 0; i + k < m && j + k < n; k++) {
                    if (s.charAt(i + k) != t.charAt(j + k)) {
                        diff++;
                    }
                    if (diff > 1) {
                        break;
                    }
                    if (diff == 1) {
                        res = (res + 1) % MOD;
                    }
                }
            }
        }

        return res;
    }
}