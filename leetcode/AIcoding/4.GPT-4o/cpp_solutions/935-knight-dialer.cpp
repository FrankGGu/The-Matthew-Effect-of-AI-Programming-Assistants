class Solution {
public:
    int knightDialer(int N) {
        const int mod = 1e9 + 7;
        vector<vector<int>> moves = {
            {4, 6},
            {6, 8},
            {7, 9},
            {4, 8},
            {},
            {},
            {0, 1, 7},
            {2, 6},
            {1, 3},
            {2, 4}
        };

        vector<vector<long>> dp(N + 1, vector<long>(10, 0));
        for (int i = 0; i < 10; i++) dp[1][i] = 1;

        for (int n = 2; n <= N; n++) {
            for (int i = 0; i < 10; i++) {
                for (int move : moves[i]) {
                    dp[n][move] = (dp[n][move] + dp[n - 1][i]) % mod;
                }
            }
        }

        long result = 0;
        for (int i = 0; i < 10; i++) {
            result = (result + dp[N][i]) % mod;
        }

        return result;
    }
};