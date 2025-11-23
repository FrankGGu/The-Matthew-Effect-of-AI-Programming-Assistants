class Solution {
    private String s, t;
    private int n, m;
    private int[][][] dp;

    public String findOriginal(String s, String t) {
        this.s = s;
        this.t = t;
        this.n = s.length();
        this.m = t.length();
        this.dp = new int[n + 1][m + 1][2];
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= m; j++) {
                dp[i][j][0] = dp[i][j][1] = -1;
            }
        }

        if (solve(0, 0, 0) == 0) {
            return "";
        }

        StringBuilder sb = new StringBuilder();
        int i = 0, j = 0, k = 0;
        while (i < n) {
            if (solve(i + 1, j, 0) == 1) {
                i++;
            } else {
                sb.append(s.charAt(i));
                if (j < m && s.charAt(i) == t.charAt(j)) {
                    j++;
                }
                i++;
            }
        }

        return sb.toString();
    }

    private int solve(int i, int j, int k) {
        if (j == m) {
            return 1;
        }
        if (i == n) {
            return 0;
        }

        if (dp[i][j][k] != -1) {
            return dp[i][j][k];
        }

        int res = 0;
        if (s.charAt(i) == t.charAt(j)) {
            res = solve(i + 1, j + 1, 0);
        }
        res |= solve(i + 1, j, 0);

        return dp[i][j][k] = res;
    }
}