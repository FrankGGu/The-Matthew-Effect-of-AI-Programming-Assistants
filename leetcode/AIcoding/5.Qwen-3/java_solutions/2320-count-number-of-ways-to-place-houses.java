public class Solution {
    public int houseOfCards(long n) {
        long[] dp = new long[100000];
        dp[0] = 1;
        for (long i = 1; i <= n; i++) {
            dp[(int) i] = dp[(int) (i - 1)] + dp[(int) (i - 2)];
        }
        return (int) dp[(int) n];
    }
}