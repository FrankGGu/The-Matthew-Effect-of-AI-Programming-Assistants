#include <vector>

using namespace std;

class Solution {
public:
    int largestMagicSquare(vector<vector<int>>& grid) {
        int n = grid.size(), m = grid[0].size();
        vector<vector<int>> rowSum(n + 1, vector<int>(m + 1, 0));
        vector<vector<int>> colSum(n + 1, vector<int>(m + 1, 0));

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= m; ++j) {
                rowSum[i][j] = rowSum[i][j - 1] + grid[i - 1][j - 1];
                colSum[i][j] = colSum[i - 1][j] + grid[i - 1][j - 1];
            }
        }

        for (int k = min(n, m); k >= 1; --k) {
            for (int i = 0; i <= n - k; ++i) {
                for (int j = 0; j <= m - k; ++j) {
                    int sum = rowSum[i + 1][j + k] - rowSum[i + 1][j];
                    bool magic = true;

                    for (int row = i + 1; row <= i + k; ++row) {
                        if (rowSum[row][j + k] - rowSum[row][j] != sum) {
                            magic = false;
                            break;
                        }
                    }

                    if (!magic) continue;

                    for (int col = j + 1; col <= j + k; ++col) {
                        if (colSum[i + k][col] - colSum[i][col] != sum) {
                            magic = false;
                            break;
                        }
                    }

                    if (!magic) continue;

                    int diag1 = 0;
                    for (int l = 0; l < k; ++l) {
                        diag1 += grid[i + l][j + l];
                    }

                    if (diag1 != sum) continue;

                    int diag2 = 0;
                    for (int l = 0; l < k; ++l) {
                        diag2 += grid[i + l][j + k - 1 - l];
                    }

                    if (diag2 != sum) continue;

                    return k;
                }
            }
        }

        return 1;
    }
};