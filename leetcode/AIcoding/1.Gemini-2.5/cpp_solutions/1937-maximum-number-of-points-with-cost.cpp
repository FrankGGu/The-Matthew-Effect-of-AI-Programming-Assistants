#include <vector>
#include <algorithm>

class Solution {
public:
    long long maxPoints(std::vector<std::vector<int>>& points) {
        int m = points.size();
        int n = points[0].size();

        std::vector<long long> dp(n);
        for (int j = 0; j < n; ++j) {
            dp[j] = points[0][j];
        }

        for (int i = 1; i < m; ++i) {
            std::vector<long long> left(n);
            left[0] = dp[0];
            for (int j = 1; j < n; ++j) {
                left[j] = std::max(dp[j], left[j - 1] - 1);
            }

            std::vector<long long> right(n);
            right[n - 1] = dp[n - 1];
            for (int j = n - 2; j >= 0; --j) {
                right[j] = std::max(dp[j], right[j + 1] - 1);
            }

            for (int j = 0; j < n; ++j) {
                dp[j] = points[i][j] + std::max(left[j], right[j]);
            }
        }

        return *std::max_element(dp.begin(), dp.end());
    }
};