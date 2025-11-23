class Solution {
    public int strangePrinter(String s) {
        if (s == null || s.length() == 0) {
            return 0;
        }

        StringBuilder sb = new StringBuilder();
        sb.append(s.charAt(0));
        for (int i = 1; i < s.length(); i++) {
            if (s.charAt(i) != s.charAt(i - 1)) {
                sb.append(s.charAt(i));
            }
        }
        s = sb.toString();

        int n = s.length();

        int[][] dp = new int[n][n];

        for (int i = 0; i < n; i++) {
            dp[i][i] = 1;
        }

        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;

                dp[i][j] = 1 + dp[i + 1][j];

                for (int k = i + 1; k <= j; k++) {
                    if (s.charAt(k) == s.charAt(i)) {
                        int turnsForRightPart = (k + 1 <= j) ? dp[k + 1][j] : 0;
                        dp[i][j] = Math.min(dp[i][j], dp[i][k - 1] + turnsForRightPart);
                    }
                }
            }
        }

        return dp[0][n - 1];
    }
}