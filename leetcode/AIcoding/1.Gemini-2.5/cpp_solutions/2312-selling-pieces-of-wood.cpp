#include <vector>
#include <algorithm>

class Solution {
public:
    long long sellingWood(int n, int m, std::vector<std::vector<int>>& prices) {
        std::vector<std::vector<long long>> dp(n + 1, std::vector<long long>(m + 1, 0));

        for (const auto& price_info : prices) {
            int h = price_info[0];
            int w = price_info[1];
            long long price = price_info[2];
            if (h <= n && w <= m) { // Ensure the piece dimensions are within the main wood piece's limits
                dp[h][w] = std::max(dp[h][w], price);
            }
        }

        for (int h = 1; h <= n; ++h) {
            for (int w = 1; w <= m; ++w) {
                // Option 1: Cut horizontally
                // Try cutting into two pieces: (i x w) and ((h-i) x w)
                for (int i = 1; i < h; ++i) {
                    dp[h][w] = std::max(dp[h][w], dp[i][w] + dp[h - i][w]);
                }

                // Option 2: Cut vertically
                // Try cutting into two pieces: (h x j) and (h x (w-j))
                for (int j = 1; j < w; ++j) {
                    dp[h][w] = std::max(dp[h][w], dp[h][j] + dp[h][w - j]);
                }
            }
        }

        return dp[n][m];
    }
};