class Solution {
public:
    int largestMagicSquare(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size(), maxSize = 1;
        vector<vector<int>> sum(m + 1, vector<int>(n + 1, 0));

        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                sum[i][j] = grid[i - 1][j - 1] + sum[i - 1][j] + sum[i][j - 1] - sum[i - 1][j - 1];
            }
        }

        for (int size = 2; size <= min(m, n); ++size) {
            for (int i = 0; i <= m - size; ++i) {
                for (int j = 0; j <= n - size; ++j) {
                    int total = sum[i + size][j + size] - sum[i][j + size] - sum[i + size][j] + sum[i][j];
                    if (total != size * size * (size * size + 1) / 2) continue;

                    int diag1 = 0, diag2 = 0;
                    for (int k = 0; k < size; ++k) {
                        diag1 += grid[i + k][j + k];
                        diag2 += grid[i + k][j + size - 1 - k];
                    }
                    if (diag1 != diag2) continue;

                    bool valid = true;
                    for (int k = 0; k < size && valid; ++k) {
                        int rowSum = 0, colSum = 0;
                        for (int l = 0; l < size; ++l) {
                            rowSum += grid[i + k][j + l];
                            colSum += grid[i + l][j + k];
                        }
                        if (rowSum != diag1 || colSum != diag1) valid = false;
                    }
                    if (valid) maxSize = size;
                }
            }
        }
        return maxSize;
    }
};