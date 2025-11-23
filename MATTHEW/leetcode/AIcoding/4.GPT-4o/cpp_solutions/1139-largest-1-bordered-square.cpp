class Solution {
public:
    int largest1BorderedSquare(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<int>> left(m, vector<int>(n, 0)), top(m, vector<int>(n, 0));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    left[i][j] = (j == 0) ? 1 : left[i][j - 1] + 1;
                    top[i][j] = (i == 0) ? 1 : top[i - 1][j] + 1;
                }
            }
        }

        int maxSize = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    int size = min(left[i][j], top[i][j]);
                    while (size > maxSize) {
                        if (top[i][j - size + 1] >= size && left[i - size + 1][j] >= size) {
                            maxSize = size;
                        }
                        --size;
                    }
                }
            }
        }

        return maxSize * maxSize;
    }
};