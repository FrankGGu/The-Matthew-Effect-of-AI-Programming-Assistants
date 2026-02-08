class Solution {
public:
    int projectionArea(vector<vector<int>>& grid) {
        int xy = 0, xz = 0, yz = 0;
        int n = grid.size(), m = grid[0].size();

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (grid[i][j] > 0) xy++;
                xz = max(xz, grid[i][j]);
                yz = max(yz, grid[i][j]);
            }
        }

        int yzSum = 0;
        for (int j = 0; j < m; ++j) {
            int colMax = 0;
            for (int i = 0; i < n; ++i) {
                colMax = max(colMax, grid[i][j]);
            }
            yzSum += colMax;
        }

        return xy + yzSum + n * xz;
    }
};