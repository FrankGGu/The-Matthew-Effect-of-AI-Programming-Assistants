#include <vector>
#include <algorithm>

class Solution {
public:
    int maxProductPath(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        std::vector<std::vector<long long>> dp_max(m, std::vector<long long>(n));
        std::vector<std::vector<long long>> dp_min(m, std::vector<long long>(n));

        dp_max[0][0] = grid[0][0];
        dp_min[0][0] = grid[0][0];

        for (int j = 1; j < n; ++j) {
            long long val = grid[0][j];
            dp_max[0][j] = dp_max[0][j-1] * val;
            dp_min[0][j] = dp_min[0][j-1] * val;
        }

        for (int i = 1; i < m; ++i) {
            long long val = grid[i][0];
            dp_max[i][0] = dp_max[i-1][0] * val;
            dp_min[i][0] = dp_min[i-1][0] * val;
        }

        for (int i = 1; i < m; ++i) {
            for (int j = 1; j < n; ++j) {
                long long val = grid[i][j];

                long long p1_max = dp_max[i-1][j] * val;
                long long p1_min = dp_min[i-1][j] * val;

                long long p2_max = dp_max[i][j-1] * val;
                long long p2_min = dp_min[i][j-1] * val;

                dp_max[i][j] = std::max({p1_max, p1_min, p2_max, p2_min});
                dp_min[i][j] = std::min({p1_max, p1_min, p2_max, p2_min});
            }
        }

        long long result = dp_max[m-1][n-1];
        long long MOD = 1e9 + 7;

        if (result < 0) {
            return -1;
        } else {
            return result % MOD;
        }
    }
};