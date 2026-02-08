class Solution {
    public int numPermutations(String s) {
        int n = s.length();
        int[][] dp = new int[n + 1][n + 1];
        int mod = 1000000007;

        dp[0][0] = 1;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= i; j++) {
                if (s.charAt(i - 1) == 'I') {
                    for (int k = 0; k < j; k++) {
                        dp[i][j] = (dp[i][j] + dp[i - 1][k]) % mod;
                    }
                } else {
                    for (int k = j; k <= i - 1; k++) {
                        dp[i][j] = (dp[i][j] + dp[i - 1][k]) % mod;
                    }
                }
            }
        }

        int ans = 0;
        for (int j = 0; j <= n; j++) {
            ans = (ans + dp[n][j]) % mod;
        }

        return ans;
    }
}