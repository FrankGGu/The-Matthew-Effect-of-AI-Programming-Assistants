#include <vector>
#include <algorithm> // For std::min

class Solution {
public:
    double champagneTower(int poured, int query_row, int query_glass) {
        std::vector<std::vector<double>> dp(query_row + 1, std::vector<double>(query_row + 1, 0.0));

        dp[0][0] = poured;

        for (int r = 0; r < query_row; ++r) {
            for (int c = 0; c <= r; ++c) {
                if (dp[r][c] > 1.0) {
                    double overflow = dp[r][c] - 1.0;
                    dp[r + 1][c] += overflow / 2.0;
                    dp[r + 1][c + 1] += overflow / 2.0;
                }
            }
        }

        return std::min(1.0, dp[query_row][query_glass]);
    }
};