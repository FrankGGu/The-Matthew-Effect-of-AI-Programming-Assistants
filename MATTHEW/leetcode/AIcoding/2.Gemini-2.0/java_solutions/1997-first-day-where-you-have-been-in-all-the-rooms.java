class Solution {
    public int firstDayBeenInAllRooms(int[] nextVisit) {
        int n = nextVisit.length;
        long[] dp = new long[n];
        dp[0] = 0;
        long mod = 1000000007;

        for (int i = 0; i < n - 1; i++) {
            int j = nextVisit[i];
            if (j < i) {
                dp[i + 1] = (2 * dp[i] - dp[j] + 2 + mod) % mod;
            } else {
                dp[i + 1] = (2 * dp[i] + 2) % mod;
            }
        }

        return (int) dp[n - 1];
    }
}