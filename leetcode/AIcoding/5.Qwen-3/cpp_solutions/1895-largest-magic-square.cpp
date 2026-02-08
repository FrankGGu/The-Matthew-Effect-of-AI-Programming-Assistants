#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int largestMagicSquare(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> rowSum(m, vector<int>(n, 0));
        vector<vector<int>> colSum(m, vector<int>(n, 0));

        for (int i = 0; i < m; ++i) {
            rowSum[i][0] = grid[i][0];
            for (int j = 1; j < n; ++j) {
                rowSum[i][j] = rowSum[i][j-1] + grid[i][j];
            }
        }

        for (int j = 0; j < n; ++j) {
            colSum[0][j] = grid[0][j];
            for (int i = 1; i < m; ++i) {
                colSum[i][j] = colSum[i-1][j] + grid[i][j];
            }
        }

        int maxLen = 1;
        for (int k = 2; k <= min(m, n); ++k) {
            for (int i = 0; i <= m - k; ++i) {
                for (int j = 0; j <= n - k; ++j) {
                    int target = rowSum[i][j + k - 1];
                    bool valid = true;

                    for (int x = i; x < i + k; ++x) {
                        if (rowSum[x][j + k - 1] - (j > 0 ? rowSum[x][j - 1] : 0) != target) {
                            valid = false;
                            break;
                        }
                    }

                    if (!valid) continue;

                    for (int y = j; y < j + k; ++y) {
                        if (colSum[i + k - 1][y] - (i > 0 ? colSum[i - 1][y] : 0) != target) {
                            valid = false;
                            break;
                        }
                    }

                    if (!valid) continue;

                    int diag1 = 0;
                    for (int x = 0; x < k; ++x) {
                        diag1 += grid[i + x][j + x];
                    }

                    if (diag1 != target) continue;

                    int diag2 = 0;
                    for (int x = 0; x < k; ++x) {
                        diag2 += grid[i + x][j + k - 1 - x];
                    }

                    if (diag2 == target) {
                        maxLen = max(maxLen, k);
                    }
                }
            }
        }

        return maxLen;
    }
};