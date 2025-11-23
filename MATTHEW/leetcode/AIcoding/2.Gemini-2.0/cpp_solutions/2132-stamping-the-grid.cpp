#include <vector>

using namespace std;

class Solution {
public:
    bool possibleToStamp(vector<vector<int>>& grid, int stampHeight, int stampWidth) {
        int m = grid.size();
        int n = grid[0].size();

        vector<vector<int>> prefixSum(m + 1, vector<int>(n + 1, 0));
        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                prefixSum[i][j] = prefixSum[i - 1][j] + prefixSum[i][j - 1] - prefixSum[i - 1][j - 1] + grid[i - 1][j - 1];
            }
        }

        vector<vector<int>> diff(m, vector<int>(n, 0));
        for (int i = 0; i <= m - stampHeight; ++i) {
            for (int j = 0; j <= n - stampWidth; ++j) {
                int sum = prefixSum[i + stampHeight][j + stampWidth] - prefixSum[i][j + stampWidth] - prefixSum[i + stampHeight][j] + prefixSum[i][j];
                if (sum == 0) {
                    diff[i][j]++;
                    if (i + stampHeight < m) diff[i + stampHeight][j]--;
                    if (j + stampWidth < n) diff[i][j + stampWidth]--;
                    if (i + stampHeight < m && j + stampWidth < n) diff[i + stampHeight][j + stampWidth]++;
                }
            }
        }

        vector<vector<int>> stampSum(m + 1, vector<int>(n + 1, 0));
        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                stampSum[i][j] = stampSum[i - 1][j] + stampSum[i][j - 1] - stampSum[i - 1][j - 1] + diff[i - 1][j - 1];
            }
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0 && stampSum[i + 1][j + 1] == 0) {
                    return false;
                }
            }
        }

        return true;
    }
};