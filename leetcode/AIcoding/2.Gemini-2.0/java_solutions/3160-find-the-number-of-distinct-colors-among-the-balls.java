import java.util.Arrays;

class Solution {
    private static final int MOD = 1000000007;

    public int distinctSequences(int[] balls) {
        int n = 0;
        for (int ball : balls) {
            n += ball;
        }

        long[][] dp = new long[n + 1][n + 1];
        dp[0][0] = 1;

        for (int i = 1; i <= n; i++) {
            dp[i][0] = 1;
            for (int j = 1; j <= i; j++) {
                dp[i][j] = (dp[i - 1][j - 1] + dp[i - 1][j]) % MOD;
            }
        }

        long ans = dp[n][n];
        for (int ball : balls) {
            ans = (ans * inverseFactorial(ball)) % MOD;
        }

        return (int) ans;
    }

    private long factorial(int n) {
        long res = 1;
        for (int i = 2; i <= n; i++) {
            res = (res * i) % MOD;
        }
        return res;
    }

    private long power(long base, int exp) {
        long res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }

    private long inverse(long n) {
        return power(n, MOD - 2);
    }

    private long inverseFactorial(int n) {
        return inverse(factorial(n));
    }
}