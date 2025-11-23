#include <vector>

using namespace std;

class Solution {
public:
    bool hasValidPath(vector<vector<char>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        if ((m + n - 1) % 2 != 0) {
            return false;
        }

        if (grid[0][0] == ')' || grid[m - 1][n - 1] == '(') {
            return false;
        }

        vector<vector<vector<bool>>> dp(m, vector<vector<bool>>(n, vector<bool>(m + n, false)));

        if (grid[0][0] == '(') {
            dp[0][0][1] = true;
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                for (int k = 0; k <= m + n - 1; ++k) {
                    if (dp[i][j][k]) {
                        if (i + 1 < m) {
                            if (grid[i + 1][j] == '(' && k + 1 <= m + n - 1) {
                                dp[i + 1][j][k + 1] = true;
                            } else if (grid[i + 1][j] == ')' && k - 1 >= 0){
                                dp[i + 1][j][k - 1] = true;
                            }
                        }
                        if (j + 1 < n) {
                            if (grid[i][j + 1] == '(' && k + 1 <= m + n - 1) {
                                dp[i][j + 1][k + 1] = true;
                            } else if (grid[i][j + 1] == ')' && k - 1 >= 0) {
                                dp[i][j + 1][k - 1] = true;
                            }
                        }
                    }
                }
            }
        }

        return dp[m - 1][n - 1][0];
    }
};