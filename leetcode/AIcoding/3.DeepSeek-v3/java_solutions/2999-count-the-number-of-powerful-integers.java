import java.math.BigInteger;

class Solution {
    public long numberOfPowerfulInt(long start, long finish, int limit, String s) {
        return compute(finish, limit, s) - compute(start - 1, limit, s);
    }

    private long compute(long n, int limit, String s) {
        String num = Long.toString(n);
        int m = s.length();
        int k = num.length();
        if (k < m) return 0;

        long[] dp = new long[k + 1];
        dp[0] = 1;
        for (int i = 1; i <= k - m; i++) {
            dp[i] = dp[i - 1] * (Math.min(limit, 9) + 1);
        }

        long res = 0;
        for (int i = 0; i < k - m; i++) {
            int d = num.charAt(i) - '0';
            if (d == 0) continue;
            long cnt = Math.min(d - 1, limit);
            res += cnt * dp[k - m - i - 1];
            if (d > limit) {
                return res + dp[k - m - i - 1];
            }
        }

        String suffix = num.substring(k - m);
        if (suffix.compareTo(s) <= 0) {
            int firstDigit = suffix.charAt(0) - '0';
            if (firstDigit <= limit) {
                res++;
            }
        }
        return res;
    }
}