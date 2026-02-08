class Solution {
    private static final int MOD = 1000000007;

    public int findGoodStrings(int n, String s1, String s2, String evil) {
        int m = evil.length();
        int[] lps = computeLPS(evil);
        Integer[][][][] dp = new Integer[n][m][2][2];
        return solve(n, s1, s2, evil, lps, 0, 0, true, true, dp);
    }

    private int solve(int n, String s1, String s2, String evil, int[] lps, int i, int evilIndex, boolean lowerBound, boolean upperBound, Integer[][][][] dp) {
        if (evilIndex == evil.length()) {
            return 0;
        }
        if (i == n) {
            return 1;
        }

        if (dp[i][evilIndex][lowerBound ? 1 : 0][upperBound ? 1 : 0] != null) {
            return dp[i][evilIndex][lowerBound ? 1 : 0][upperBound ? 1 : 0];
        }

        int count = 0;
        char start = lowerBound ? s1.charAt(i) : 'a';
        char end = upperBound ? s2.charAt(i) : 'z';

        for (char c = start; c <= end; c++) {
            int newEvilIndex = evilIndex;
            while (newEvilIndex > 0 && c != evil.charAt(newEvilIndex)) {
                newEvilIndex = lps[newEvilIndex - 1];
            }
            if (c == evil.charAt(newEvilIndex)) {
                newEvilIndex++;
            }

            count = (count + solve(n, s1, s2, evil, lps, i + 1, newEvilIndex, lowerBound && (c == s1.charAt(i)), upperBound && (c == s2.charAt(i)), dp)) % MOD;
        }

        return dp[i][evilIndex][lowerBound ? 1 : 0][upperBound ? 1 : 0] = count;
    }

    private int[] computeLPS(String evil) {
        int m = evil.length();
        int[] lps = new int[m];
        int len = 0;
        lps[0] = 0;
        int i = 1;
        while (i < m) {
            if (evil.charAt(i) == evil.charAt(len)) {
                len++;
                lps[i] = len;
                i++;
            } else {
                if (len != 0) {
                    len = lps[len - 1];
                } else {
                    lps[i] = 0;
                    i++;
                }
            }
        }
        return lps;
    }
}