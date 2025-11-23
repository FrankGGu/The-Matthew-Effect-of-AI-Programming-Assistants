class Solution {
public:
    int matrixScore(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        for (int i = 0; i < m; ++i) {
            if (grid[i][0] == 0) {
                for (int j = 0; j < n; ++j) {
                    grid[i][j] ^= 1;
                }
            }
        }

        for (int j = 1; j < n; ++j) {
            int count = 0;
            for (int i = 0; i < m; ++i) {
                if (grid[i][j] == 1) {
                    count++;
                }
            }
            if (count < m - count) {
                for (int i = 0; i < m; ++i) {
                    grid[i][j] ^= 1;
                }
            }
        }

        int score = 0;
        for (int i = 0; i < m; ++i) {
            int row = 0;
            for (int j = 0; j < n; ++j) {
                row = (row << 1) | grid[i][j];
            }
            score += row;
        }

        return score;
    }
};