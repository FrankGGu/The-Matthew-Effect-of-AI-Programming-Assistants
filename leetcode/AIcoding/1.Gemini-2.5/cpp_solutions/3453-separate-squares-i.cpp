#include <vector>
#include <algorithm>

class Solution {
public:
    int numSquares(int n) {
        static std::vector<int> dp{0};
        while (dp.size() <= n) {
            int m = dp.size();
            int min_val = m;
            for (int i = 1; i * i <= m; ++i) {
                min_val = std::min(min_val, dp[m - i * i] + 1);
            }
            dp.push_back(min_val);
        }
        return dp[n];
    }
};