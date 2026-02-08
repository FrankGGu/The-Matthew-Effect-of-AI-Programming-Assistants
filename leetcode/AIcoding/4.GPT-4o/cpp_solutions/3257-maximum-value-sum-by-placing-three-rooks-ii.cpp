class Solution {
public:
    int maxSum(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        int maxSum = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int sum = grid[i][j];
                for (int k = i + 1; k < m; ++k) {
                    sum += grid[k][j];
                    for (int l = j + 1; l < n; ++l) {
                        sum += grid[k][l];
                        maxSum = max(maxSum, sum);
                        sum -= grid[k][l];
                    }
                    sum -= grid[k][j];
                }
                sum = grid[i][j];
            }
        }
        return maxSum;
    }
};