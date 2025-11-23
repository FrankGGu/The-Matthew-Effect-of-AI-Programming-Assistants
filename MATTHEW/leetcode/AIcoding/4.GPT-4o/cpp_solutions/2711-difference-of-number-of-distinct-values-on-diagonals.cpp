class Solution {
public:
    vector<int> differenceOfDistinctValues(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<int> result(m, vector<int>(n, 0));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                set<int> leftDiagonal, rightDiagonal;
                for (int k = 1; k < m; ++k) {
                    if (i + k < m && j + k < n) leftDiagonal.insert(grid[i + k][j + k]);
                    if (i + k < m && j - k >= 0) rightDiagonal.insert(grid[i + k][j - k]);
                }
                for (int k = 1; k < m; ++k) {
                    if (i - k >= 0 && j + k < n) leftDiagonal.insert(grid[i - k][j + k]);
                    if (i - k >= 0 && j - k >= 0) rightDiagonal.insert(grid[i - k][j - k]);
                }
                result[i][j] = abs(leftDiagonal.size() - rightDiagonal.size());
            }
        }

        return result;
    }
};