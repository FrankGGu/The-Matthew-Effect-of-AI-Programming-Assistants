class Solution {
public:
    int peopleAwareOfSecret(int n, int delay, int forget) {
        const int MOD = 1e9 + 7;
        vector<long long> dp(n + 1, 0);
        dp[1] = 1;
        long long total = 0;
        for (int i = 2; i <= n; ++i) {
            long long new_people = 0;
            if (i - delay >= 1) {
                new_people = dp[i - delay];
            }
            if (i - forget >= 1) {
                new_people = (new_people - dp[i - forget] + MOD) % MOD;
            }
            dp[i] = (dp[i - 1] + new_people) % MOD;
        }
        return (dp[n] - (n - forget >= 1 ? dp[n - forget] : 0) + MOD) % MOD;
    }
};