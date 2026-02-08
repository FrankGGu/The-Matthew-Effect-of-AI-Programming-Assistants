class Solution {
public:
    int minFallingPathSum(vector<vector<int>>& grid) {
        int n = grid.size();
        if (n == 0) return 0;
        int m = grid[0].size();

        for (int i = n - 2; i >= 0; --i) {
            for (int j = 0; j < m; ++j) {
                int min_val = INT_MAX;
                for (int k = 0; k < m; ++k) {
                    if (k != j) {
                        min_val = min(min_val, grid[i + 1][k]);
                    }
                }
                grid[i][j] += min_val;
            }
        }

        return *min_element(grid[0].begin(), grid[0].end());
    }
};