class Solution {
    public int numberOfPeopleAwareOfSecret(int n, int delay, int forget) {
        int MOD = 1000000007;
        long[] dp = new long[n + 1];
        dp[1] = 1;
        long shared = 0;

        for (int i = 2; i <= n; i++) {
            long newPeople = shared;
            dp[i] = newPeople;

            shared = (shared - dp[i - forget + 1] + MOD) % MOD;
            shared = (shared + dp[i - delay + 1]) % MOD;
        }

        long ans = 0;
        for (int i = n - forget + 1; i <= n; i++) {
            ans = (ans + dp[i]) % MOD;
        }
        if (n < forget){
            for (int i = 1; i <= n; i++){
                ans = (ans + dp[i]) % MOD;
            }
        }

        return (int) ans;
    }
}