class Solution {
    public int minimumDistance(String word) {
        int n = word.length();
        int[][][] dp = new int[n + 1][27][27];
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j < 27; j++) {
                for (int k = 0; k < 27; k++) {
                    dp[i][j][k] = Integer.MAX_VALUE;
                }
            }
        }
        dp[0][26][26] = 0;
        for (int i = 0; i < n; i++) {
            int c = word.charAt(i) - 'A';
            for (int j = 0; j < 27; j++) {
                for (int k = 0; k < 27; k++) {
                    if (dp[i][j][k] != Integer.MAX_VALUE) {
                        int dist1 = (j == 26) ? 0 : distance(j, c);
                        int dist2 = (k == 26) ? 0 : distance(k, c);
                        dp[i + 1][c][k] = Math.min(dp[i + 1][c][k], dp[i][j][k] + dist1);
                        dp[i + 1][j][c] = Math.min(dp[i + 1][j][c], dp[i][j][k] + dist2);
                    }
                }
            }
        }
        int ans = Integer.MAX_VALUE;
        for (int i = 0; i < 27; i++) {
            for (int j = 0; j < 27; j++) {
                ans = Math.min(ans, dp[n][i][j]);
            }
        }
        return ans;
    }

    private int distance(int a, int b) {
        int ax = a / 6;
        int ay = a % 6;
        int bx = b / 6;
        int by = b % 6;
        return Math.abs(ax - bx) + Math.abs(ay - by);
    }
}