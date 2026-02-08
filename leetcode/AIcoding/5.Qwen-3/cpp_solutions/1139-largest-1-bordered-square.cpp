#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int largest1BorderedSquare(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> dp(m, vector<int>(n, 0));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    dp[i][j] = 1;
                    if (i > 0 && j > 0) {
                        dp[i][j] = min(dp[i-1][j-1], min(dp[i-1][j], dp[i][j-1])) + 1;
                    }
                }
            }
        }

        int maxLen = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int len = dp[i][j];
                if (len > maxLen) {
                    maxLen = len;
                }
            }
        }

        return maxLen * maxLen;
    }
};