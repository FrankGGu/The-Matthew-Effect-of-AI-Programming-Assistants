class Solution {
    private static final int MOD = 1000000007;
    private int[] fail;
    private int[][] transition;
    private String evil;

    public int findGoodStrings(int n, String s1, String s2, String evil) {
        this.evil = evil;
        buildFailureFunction();
        buildTransitionTable();
        int total = countLessOrEqual(s2);
        total = (total - countLessOrEqual(s1) + MOD) % MOD;
        if (!s1.contains(evil)) {
            total = (total + 1) % MOD;
        }
        return total;
    }

    private void buildFailureFunction() {
        int m = evil.length();
        fail = new int[m];
        fail[0] = 0;
        for (int i = 1, j = 0; i < m; i++) {
            while (j > 0 && evil.charAt(i) != evil.charAt(j)) {
                j = fail[j - 1];
            }
            if (evil.charAt(i) == evil.charAt(j)) {
                j++;
            }
            fail[i] = j;
        }
    }

    private void buildTransitionTable() {
        int m = evil.length();
        transition = new int[m][26];
        for (int i = 0; i < m; i++) {
            for (char c = 'a'; c <= 'z'; c++) {
                int j = i;
                while (j > 0 && evil.charAt(j) != c) {
                    j = fail[j - 1];
                }
                if (evil.charAt(j) == c) {
                    j++;
                }
                transition[i][c - 'a'] = j;
            }
        }
    }

    private int countLessOrEqual(String s) {
        int n = s.length();
        int m = evil.length();
        int[][][] dp = new int[n + 1][m + 1][2];
        dp[0][0][1] = 1;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                for (int k = 0; k < 2; k++) {
                    if (dp[i][j][k] == 0) continue;
                    char upper = (k == 1) ? s.charAt(i) : 'z';
                    for (char c = 'a'; c <= upper; c++) {
                        int newK = (k == 1 && c == upper) ? 1 : 0;
                        int newJ = transition[j][c - 'a'];
                        if (newJ == m) continue;
                        dp[i + 1][newJ][newK] = (dp[i + 1][newJ][newK] + dp[i][j][k]) % MOD;
                    }
                }
            }
        }
        int res = 0;
        for (int j = 0; j < m; j++) {
            res = (res + dp[n][j][0]) % MOD;
            res = (res + dp[n][j][1]) % MOD;
        }
        return res;
    }
}