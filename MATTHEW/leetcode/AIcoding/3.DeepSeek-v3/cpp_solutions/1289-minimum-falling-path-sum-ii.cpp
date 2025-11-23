class Solution {
public:
    int minFallingPathSum(vector<vector<int>>& grid) {
        int n = grid.size();
        if (n == 1) return grid[0][0];

        vector<int> dp = grid[0];

        for (int i = 1; i < n; ++i) {
            vector<int> new_dp(n, INT_MAX);
            int min1 = INT_MAX, min2 = INT_MAX;
            int min1_idx = -1;

            for (int j = 0; j < n; ++j) {
                if (dp[j] < min1) {
                    min2 = min1;
                    min1 = dp[j];
                    min1_idx = j;
                } else if (dp[j] < min2) {
                    min2 = dp[j];
                }
            }

            for (int j = 0; j < n; ++j) {
                if (j != min1_idx) {
                    new_dp[j] = min1 + grid[i][j];
                } else {
                    new_dp[j] = min2 + grid[i][j];
                }
            }

            dp = move(new_dp);
        }

        return *min_element(dp.begin(), dp.end());
    }
};