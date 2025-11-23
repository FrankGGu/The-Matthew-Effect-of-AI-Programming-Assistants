#include <vector>

using namespace std;

class Solution {
public:
    int equalSumGrid(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<vector<long long>> prefixSum(n + 1, vector<long long>(n + 1, 0));

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= n; ++j) {
                prefixSum[i][j] = prefixSum[i - 1][j] + prefixSum[i][j - 1] - prefixSum[i - 1][j - 1] + grid[i - 1][j - 1];
            }
        }

        for (int r = 0; r < n - 1; ++r) {
            for (int c = 0; c < n - 1; ++c) {
                long long sum1 = prefixSum[r + 1][c + 1];
                long long sum2 = prefixSum[r + 1][n] - sum1;
                long long sum3 = prefixSum[n][c + 1] - sum1;
                long long sum4 = prefixSum[n][n] - sum1 - sum2 - sum3;

                if (sum1 == sum2 && sum1 == sum3 && sum1 == sum4) {
                    return 1;
                }
            }
        }

        return 0;
    }
};