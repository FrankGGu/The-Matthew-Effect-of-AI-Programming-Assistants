class Solution {
public:
    int minFlips(vector<vector<int>>& grid) {
        int n = grid.size();
        int m = grid[0].size();
        int flips = 0;

        for (int i = 0; i < n / 2; ++i) {
            for (int j = 0; j < m; ++j) {
                flips += (grid[i][j] != grid[n - 1 - i][j]);
            }
        }

        for (int j = 0; j < m / 2; ++j) {
            for (int i = 0; i < n; ++i) {
                flips += (grid[i][j] != grid[i][m - 1 - j]);
            }
        }

        return flips;
    }
};