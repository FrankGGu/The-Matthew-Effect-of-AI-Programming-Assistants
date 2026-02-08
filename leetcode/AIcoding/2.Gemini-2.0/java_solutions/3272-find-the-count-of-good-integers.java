class Solution {
    private int[][] dp;

    public int countGoodNumbers(long n) {
        dp = new int[2][61];
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 61; j++) {
                dp[i][j] = -1;
            }
        }
        return solve(0, n);
    }

    private int solve(int parity, long remaining) {
        if (remaining == 0) {
            return 1;
        }
        if (dp[parity][(int) Math.floor(Math.log(remaining) / Math.log(2))] != -1) {
            return dp[parity][(int) Math.floor(Math.log(remaining) / Math.log(2))];
        }

        long powerOfTwo = 1L << ((int) Math.floor(Math.log(remaining) / Math.log(2)));
        int ans = 0;
        if (parity == 0) {
            ans = (int) (((5L * solve(1, remaining - powerOfTwo)) % 1000000007) + solve(1, remaining - powerOfTwo)) % 1000000007;
        } else {
            ans = (int) (((4L * solve(0, remaining - powerOfTwo)) % 1000000007) + solve(0, remaining - powerOfTwo)) % 1000000007;
        }

        ans = (int) ((ans + (1L * ((parity == 0 ? 5 : 4) % 1000000007) * (powerOfTwo % 1000000007) % 1000000007 * (solve(parity, remaining - powerOfTwo)))) % 1000000007);
        dp[parity][(int) Math.floor(Math.log(remaining) / Math.log(2))] = ans;
        return ans;
    }

    private int solve(int parity, long remaining, int index) {
        if (index < 0) {
            return 1;
        }
        if (dp[parity][index] != -1) {
            return dp[parity][index];
        }

        int ans = 0;
        int limit = (int) ((remaining >> index) & 1);
        for (int digit = 0; digit <= (limit == 1 ? 1 : 0); digit++) {
            if ((index + parity) % 2 == 0) {
                if (digit == 0) {
                    ans = (ans + solve(1, remaining, index - 1)) % 1000000007;
                } else {
                    ans = (ans + solve(1, remaining, index - 1)) % 1000000007;
                }
            } else {
                if (digit == 0) {
                    ans = (ans + solve(0, remaining, index - 1)) % 1000000007;
                } else {
                    ans = (ans + solve(0, remaining, index - 1)) % 1000000007;
                }
            }
        }

        dp[parity][index] = ans;
        return ans;
    }

    public int countGoodNumbersIterative(long n) {
        long even = (n + 1) / 2;
        long odd = n / 2;

        long ansEven = power(5, even);
        long ansOdd = power(4, odd);

        return (int) ((ansEven * ansOdd) % 1000000007);
    }

    private long power(long base, long exp) {
        long res = 1;
        base %= 1000000007;
        while (exp > 0) {
            if ((exp & 1) == 1) res = (res * base) % 1000000007;
            base = (base * base) % 1000000007;
            exp >>= 1;
        }
        return res;
    }
}