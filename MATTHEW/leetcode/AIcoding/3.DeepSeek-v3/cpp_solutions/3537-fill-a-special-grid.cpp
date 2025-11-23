class Solution {
public:
    vector<vector<int>> fillGrid(vector<vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return grid;
        int n = grid[0].size();
        if (n == 0) return grid;

        vector<vector<int>> result(m, vector<int>(n, 0));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    for (int k = 0; k < m; ++k) {
                        result[k][j] = 1;
                    }
                    for (int k = 0; k < n; ++k) {
                        result[i][k] = 1;
                    }
                }
            }
        }

        return result;
    }
};