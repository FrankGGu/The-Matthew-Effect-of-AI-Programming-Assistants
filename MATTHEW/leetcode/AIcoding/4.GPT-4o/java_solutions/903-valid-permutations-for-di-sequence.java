class Solution {
    public int numPermsDISequence(String S) {
        int n = S.length();
        int MOD = 1000000007;
        long[][] dp = new long[n + 1][n + 1];
        dp[0][0] = 1;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= i; j++) {
                if (S.charAt(i - 1) == 'I') {
                    for (int k = j; k < i; k++) {
                        dp[i][k + 1] = (dp[i][k + 1] + dp[i - 1][k]) % MOD;
                    }
                } else {
                    for (int k = 0; k < j; k++) {
                        dp[i][k] = (dp[i][k] + dp[i - 1][k]) % MOD;
                    }
                    for (int k = j; k < i; k++) {
                        dp[i][k] = (dp[i][k] + dp[i - 1][k + 1]) % MOD;
                    }
                }
            }
        }

        long result = 0;
        for (int j = 0; j <= n; j++) {
            result = (result + dp[n][j]) % MOD;
        }

        return (int) result;
    }
}