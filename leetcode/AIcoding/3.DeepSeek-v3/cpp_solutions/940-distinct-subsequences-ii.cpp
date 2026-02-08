class Solution {
public:
    int distinctSubseqII(string s) {
        const int MOD = 1e9 + 7;
        vector<long> dp(26, 0);
        long total = 0;
        for (char c : s) {
            long old = dp[c - 'a'];
            dp[c - 'a'] = (total + 1) % MOD;
            total = (total + dp[c - 'a'] - old + MOD) % MOD;
        }
        return total;
    }
};