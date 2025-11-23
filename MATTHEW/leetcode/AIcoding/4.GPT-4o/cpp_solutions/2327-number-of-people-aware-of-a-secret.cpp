class Solution {
public:
    int peopleAwareOfSecret(int n, int delay, int forget) {
        vector<long long> dp(n + 1);
        dp[1] = 1;
        long long total = 0;

        for (int i = 1; i <= n; ++i) {
            if (i >= delay) total += dp[i - delay];
            if (i >= forget) total -= dp[i - forget];
            dp[i] = total;
        }

        return (total + 1e9 + 7) % (1e9 + 7);
    }
};