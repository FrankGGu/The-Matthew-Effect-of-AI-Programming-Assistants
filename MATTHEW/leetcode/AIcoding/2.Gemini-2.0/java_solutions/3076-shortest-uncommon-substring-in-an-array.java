class Solution {
    public int shortestUncommonSubsequence(String[] source, String target) {
        int n = source.length;
        int m = target.length();
        int[][][] dp = new int[n + 1][m + 1][m + 1];
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= m; j++) {
                for (int k = 0; k <= m; k++) {
                    dp[i][j][k] = Integer.MAX_VALUE / 2;
                }
            }
        }
        for (int i = 0; i <= n; i++) {
            for (int k = 0; k <= m; k++) {
                dp[i][m][k] = 0;
            }
        }
        for (int i = n - 1; i >= 0; i--) {
            for (int j = m - 1; j >= 0; j--) {
                for (int k = 0; k <= m; k++) {
                    int index = -1;
                    for (int l = k; l < m; l++) {
                        if (target.charAt(l) == source[i].charAt(j)) {
                            index = l;
                            break;
                        }
                    }
                    if (index == -1) {
                        dp[i][j][k] = 1;
                    } else {
                        dp[i][j][k] = Math.min(1 + dp[i][j + 1][k], dp[i + 1][j][index + 1]);
                    }
                }
            }
        }
        int ans = dp[0][0][0];
        return ans >= Integer.MAX_VALUE / 2 ? -1 : ans;
    }
}