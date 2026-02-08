class Solution {
public:
    int largestMagicSquare(vector<vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return 0;
        int n = grid[0].size();
        vector<vector<int>> rowPrefix(m + 1, vector<int>(n + 1, 0));
        vector<vector<int>> colPrefix(m + 1, vector<int>(n + 1, 0));
        vector<vector<int>> diagPrefix(m + 1, vector<int>(n + 1, 0));
        vector<vector<int>> antiDiagPrefix(m + 1, vector<int>(n + 1, 0));

        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                rowPrefix[i][j] = rowPrefix[i][j - 1] + grid[i - 1][j - 1];
                colPrefix[i][j] = colPrefix[i - 1][j] + grid[i - 1][j - 1];
                diagPrefix[i][j] = diagPrefix[i - 1][j - 1] + grid[i - 1][j - 1];
                antiDiagPrefix[i][j] = antiDiagPrefix[i - 1][j + 1] + (j <= n ? grid[i - 1][j - 1] : 0);
            }
        }

        int maxSize = min(m, n);
        for (int k = maxSize; k >= 1; --k) {
            for (int i = 0; i + k <= m; ++i) {
                for (int j = 0; j + k <= n; ++j) {
                    int sum = diagPrefix[i + k][j + k] - diagPrefix[i][j];
                    bool valid = true;

                    for (int l = 0; l < k; ++l) {
                        if (rowPrefix[i + l + 1][j + k] - rowPrefix[i + l + 1][j] != sum) {
                            valid = false;
                            break;
                        }
                        if (colPrefix[i + k][j + l + 1] - colPrefix[i][j + l + 1] != sum) {
                            valid = false;
                            break;
                        }
                    }

                    if (!valid) continue;
                    if (antiDiagPrefix[i + k][j + 1] - antiDiagPrefix[i][j + k + 1] != sum) {
                        continue;
                    }
                    return k;
                }
            }
        }
        return 1;
    }
};