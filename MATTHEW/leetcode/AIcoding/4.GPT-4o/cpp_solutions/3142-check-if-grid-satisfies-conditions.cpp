class Solution {
public:
    bool checkGrid(vector<vector<int>>& grid) {
        int n = grid.size();
        int m = grid[0].size();
        vector<int> rowSum(n, 0), colSum(m, 0);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                rowSum[i] += grid[i][j];
                colSum[j] += grid[i][j];
            }
        }

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (grid[i][j] != rowSum[i] + colSum[j] - grid[i][j]) {
                    return false;
                }
            }
        }

        return true;
    }
};