class Solution {
public:
    int knightDialer(int n) {
        if (n == 1) return 10;
        const int MOD = 1e9 + 7;
        vector<vector<int>> moves = {
            {4, 6},
            {6, 8},
            {7, 9},
            {4, 8},
            {0, 3, 9},
            {},
            {0, 1, 7},
            {2, 6},
            {1, 3},
            {2, 4}
        };
        vector<long> dp(10, 1);
        for (int step = 2; step <= n; ++step) {
            vector<long> new_dp(10, 0);
            for (int i = 0; i < 10; ++i) {
                for (int next : moves[i]) {
                    new_dp[next] = (new_dp[next] + dp[i]) % MOD;
                }
            }
            dp = new_dp;
        }
        long total = 0;
        for (long num : dp) {
            total = (total + num) % MOD;
        }
        return total;
    }
};