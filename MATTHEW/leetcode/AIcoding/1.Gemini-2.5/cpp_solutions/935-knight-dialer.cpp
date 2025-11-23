#include <vector>
#include <numeric>

class Solution {
public:
    int knightDialer(int n) {
        if (n == 0) {
            return 0;
        }

        long long MOD = 1e9 + 7;

        std::vector<std::vector<int>> next_moves = {
            {4, 6},    // 0 can move to 4, 6
            {6, 8},    // 1 can move to 6, 8
            {7, 9},    // 2 can move to 7, 9
            {4, 8},    // 3 can move to 4, 8
            {0, 3, 9}, // 4 can move to 0, 3, 9
            {},        // 5 has no moves
            {0, 1, 7}, // 6 can move to 0, 1, 7
            {2, 6},    // 7 can move to 2, 6
            {1, 3},    // 8 can move to 1, 3
            {2, 4}     // 9 can move to 2, 4
        };

        std::vector<long long> dp(10, 1); // dp[i] stores ways to end on digit i for current length

        for (int k = 2; k <= n; ++k) {
            std::vector<long long> next_dp(10, 0);
            for (int prev_digit = 0; prev_digit < 10; ++prev_digit) {
                if (dp[prev_digit] == 0) continue; 
                for (int next_digit : next_moves[prev_digit]) {
                    next_dp[next_digit] = (next_dp[next_digit] + dp[prev_digit]) % MOD;
                }
            }
            dp = next_dp;
        }

        long long total_ways = 0;
        for (int i = 0; i < 10; ++i) {
            total_ways = (total_ways + dp[i]) % MOD;
        }

        return static_cast<int>(total_ways);
    }
};