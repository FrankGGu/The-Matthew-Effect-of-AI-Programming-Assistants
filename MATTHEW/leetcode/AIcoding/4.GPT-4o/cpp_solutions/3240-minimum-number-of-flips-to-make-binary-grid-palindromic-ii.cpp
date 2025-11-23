class Solution {
public:
    int minFlips(vector<vector<int>>& grid) {
        int n = grid.size();
        int m = grid[0].size();
        int flips = 0;

        for (int i = 0; i < n / 2; ++i) {
            for (int j = 0; j < m; ++j) {
                if (grid[i][j] != grid[n - 1 - i][j]) {
                    flips++;
                }
            }
        }

        for (int j = 0; j < m / 2; ++j) {
            for (int i = 0; i < n; ++i) {
                if (grid[i][j] != grid[i][m - 1 - j]) {
                    flips++;
                }
            }
        }

        if (n % 2 == 1) {
            for (int j = 0; j < m; ++j) {
                if (grid[n / 2][j] == 0) {
                    flips++;
                }
            }
        }

        if (m % 2 == 1) {
            for (int i = 0; i < n; ++i) {
                if (grid[i][m / 2] == 0) {
                    flips++;
                }
            }
        }

        return flips;
    }
};