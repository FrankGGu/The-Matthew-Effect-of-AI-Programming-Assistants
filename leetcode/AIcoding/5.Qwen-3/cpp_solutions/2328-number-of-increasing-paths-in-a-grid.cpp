#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int countPaths(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> dp(m, vector<int>(n, 1));
        vector<vector<int>> sortedIndices;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                sortedIndices.push_back({grid[i][j], i, j});
            }
        }

        sort(sortedIndices.begin(), sortedIndices.end());

        for (auto& idx : sortedIndices) {
            int val = idx[0];
            int i = idx[1];
            int j = idx[2];

            if (i > 0 && grid[i-1][j] < val) {
                dp[i][j] += dp[i-1][j];
            }
            if (i < m-1 && grid[i+1][j] < val) {
                dp[i][j] += dp[i+1][j];
            }
            if (j > 0 && grid[i][j-1] < val) {
                dp[i][j] += dp[i][j-1];
            }
            if (j < n-1 && grid[i][j+1] < val) {
                dp[i][j] += dp[i][j+1];
            }
        }

        int result = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                result += dp[i][j];
            }
        }

        return result;
    }
};