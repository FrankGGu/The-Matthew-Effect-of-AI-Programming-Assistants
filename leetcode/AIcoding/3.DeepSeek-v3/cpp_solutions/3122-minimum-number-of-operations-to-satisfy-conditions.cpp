class Solution {
public:
    int minimumOperations(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> freq(n, vector<int>(10, 0));

        for (int j = 0; j < n; ++j) {
            for (int i = 0; i < m; ++i) {
                freq[j][grid[i][j]]++;
            }
        }

        vector<vector<int>> dp(n, vector<int>(10, INT_MAX));
        for (int d = 0; d < 10; ++d) {
            dp[0][d] = m - freq[0][d];
        }

        for (int j = 1; j < n; ++j) {
            for (int d = 0; d < 10; ++d) {
                int min_prev = INT_MAX;
                for (int prev_d = 0; prev_d < 10; ++prev_d) {
                    if (prev_d != d) {
                        min_prev = min(min_prev, dp[j-1][prev_d]);
                    }
                }
                dp[j][d] = min_prev + (m - freq[j][d]);
            }
        }

        int result = INT_MAX;
        for (int d = 0; d < 10; ++d) {
            result = min(result, dp[n-1][d]);
        }
        return result;
    }
};