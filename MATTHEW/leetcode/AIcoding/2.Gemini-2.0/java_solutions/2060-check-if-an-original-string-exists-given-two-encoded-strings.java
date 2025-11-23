class Solution {
    private int[][][] dp;
    private String s1, s2;

    public boolean possiblyEquals(String s1, String s2) {
        this.s1 = s1;
        this.s2 = s2;
        dp = new int[41][41][2001];
        for (int i = 0; i <= 40; i++) {
            for (int j = 0; j <= 40; j++) {
                for (int k = 0; k <= 2000; k++) {
                    dp[i][j][k] = -1;
                }
            }
        }
        return solve(0, 0, 1000);
    }

    private boolean solve(int i, int j, int diff) {
        if (i == s1.length() && j == s2.length()) {
            return diff == 1000;
        }
        if (dp[i][j][diff] != -1) {
            return dp[i][j][diff] == 1;
        }

        boolean res = false;

        if (i < s1.length() && Character.isDigit(s1.charAt(i))) {
            int k = i;
            int num = 0;
            while (k < s1.length() && Character.isDigit(s1.charAt(k))) {
                num = num * 10 + (s1.charAt(k) - '0');
                k++;
                if (solve(k, j, diff + num)) {
                    res = true;
                    break;
                }
            }
        } else if (j < s2.length() && Character.isDigit(s2.charAt(j))) {
            int k = j;
            int num = 0;
            while (k < s2.length() && Character.isDigit(s2.charAt(k))) {
                num = num * 10 + (s2.charAt(k) - '0');
                k++;
                if (solve(i, k, diff - num)) {
                    res = true;
                    break;
                }
            }
        } else if (i < s1.length() && j < s2.length() && s1.charAt(i) == s2.charAt(j)) {
            if (diff == 1000) {
                res = solve(i + 1, j + 1, diff);
            }
        } else {
            if (i < s1.length() && diff > 1000) {
                if (solve(i + 1, j, diff - 1)) {
                    res = true;
                }
            }
            if (j < s2.length() && diff < 1000) {
                if (solve(i, j + 1, diff + 1)) {
                    res = true;
                }
            }
        }

        dp[i][j][diff] = res ? 1 : 0;
        return res;
    }
}