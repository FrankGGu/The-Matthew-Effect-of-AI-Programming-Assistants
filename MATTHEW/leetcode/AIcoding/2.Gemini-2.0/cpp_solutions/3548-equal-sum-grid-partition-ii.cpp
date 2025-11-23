#include <vector>

using namespace std;

class Solution {
public:
    bool equalSumGrid(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<vector<long long>> prefixSum(n + 1, vector<long long>(n + 1, 0));

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= n; ++j) {
                prefixSum[i][j] = prefixSum[i - 1][j] + prefixSum[i][j - 1] - prefixSum[i - 1][j - 1] + grid[i - 1][j - 1];
            }
        }

        for (int row = 1; row < n; ++row) {
            for (int col = 1; col < n; ++col) {
                long long top_left = prefixSum[row][col];
                long long top_right = prefixSum[row][n] - prefixSum[row][col];
                long long bottom_left = prefixSum[n][col] - prefixSum[row][col];
                long long bottom_right = prefixSum[n][n] - prefixSum[row][n] - prefixSum[n][col] + prefixSum[row][col];

                if (top_left == top_right && top_left == bottom_left && top_left == bottom_right) {
                    return true;
                }
            }
        }

        return false;
    }
};