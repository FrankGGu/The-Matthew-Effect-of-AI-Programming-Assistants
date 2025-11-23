#include <vector>

using namespace std;

class Solution {
public:
    int knightDialer(int n) {
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

        int MOD = 1e9 + 7;

        vector<int> dp(10, 1);

        for (int i = 1; i < n; ++i) {
            vector<int> next_dp(10, 0);
            for (int j = 0; j < 10; ++j) {
                for (int move : moves[j]) {
                    next_dp[move] = (next_dp[move] + dp[j]) % MOD;
                }
            }
            dp = next_dp;
        }

        int total = 0;
        for (int i = 0; i < 10; ++i) {
            total = (total + dp[i]) % MOD;
        }

        return total;
    }
};