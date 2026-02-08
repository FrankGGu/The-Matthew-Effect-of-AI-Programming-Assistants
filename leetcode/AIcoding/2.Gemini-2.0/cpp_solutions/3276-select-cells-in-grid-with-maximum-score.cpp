#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxPoints(vector<vector<int>>& grid, vector<int>& cost) {
        int m = grid.size();
        int n = grid[0].size();

        vector<long long> dp(n);
        for (int j = 0; j < n; ++j) {
            dp[j] = grid[0][j];
        }

        for (int i = 1; i < m; ++i) {
            vector<long long> left(n), right(n);
            left[0] = dp[0];
            for (int j = 1; j < n; ++j) {
                left[j] = max(left[j - 1] - 1, dp[j]);
            }

            right[n - 1] = dp[n - 1];
            for (int j = n - 2; j >= 0; --j) {
                right[j] = max(right[j + 1] - 1, dp[j]);
            }

            vector<long long> new_dp(n);
            for (int j = 0; j < n; ++j) {
                new_dp[j] = max(left[j], right[j]) + grid[i][j] - cost[j];
            }

            dp = new_dp;
        }

        long long ans = 0;
        for (int j = 0; j < n; ++j) {
            ans = max(ans, dp[j]);
        }

        return ans;
    }
};