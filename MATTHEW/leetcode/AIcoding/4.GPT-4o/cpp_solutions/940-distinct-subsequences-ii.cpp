class Solution {
public:
    int distinctSubseqII(string s) {
        const int MOD = 1e9 + 7;
        int n = s.size();
        vector<long long> dp(n + 1, 0);
        unordered_map<char, long long> last;

        dp[0] = 1; // empty subsequence

        for (int i = 1; i <= n; ++i) {
            dp[i] = (2 * dp[i - 1]) % MOD;
            if (last.count(s[i - 1])) {
                dp[i] = (dp[i] - dp[last[s[i - 1]] - 1] + MOD) % MOD;
            }
            last[s[i - 1]] = i;
        }

        return (dp[n] - 1 + MOD) % MOD;
    }
};