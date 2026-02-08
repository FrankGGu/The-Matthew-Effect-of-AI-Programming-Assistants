#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int orderOfLargestPlusSign(vector<vector<int>>& grid) {
        int n = grid.size();
        int m = grid[0].size();
        vector<vector<int>> left(n, vector<int>(m, 0));
        vector<vector<int>> right(n, vector<int>(m, 0));
        vector<vector<int>> up(n, vector<int>(m, 0));
        vector<vector<int>> down(n, vector<int>(m, 0));

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (grid[i][j] == 1) {
                    left[i][j] = (j > 0) ? left[i][j - 1] + 1 : 1;
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            for (int j = m - 1; j >= 0; --j) {
                if (grid[i][j] == 1) {
                    right[i][j] = (j < m - 1) ? right[i][j + 1] + 1 : 1;
                }
            }
        }

        for (int j = 0; j < m; ++j) {
            for (int i = 0; i < n; ++i) {
                if (grid[i][j] == 1) {
                    up[i][j] = (i > 0) ? up[i - 1][j] + 1 : 1;
                }
            }
        }

        for (int j = 0; j < m; ++j) {
            for (int i = n - 1; i >= 0; --i) {
                if (grid[i][j] == 1) {
                    down[i][j] = (i < n - 1) ? down[i + 1][j] + 1 : 1;
                }
            }
        }

        int maxLen = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                int len = min(left[i][j], right[i][j]);
                len = min(len, up[i][j]);
                len = min(len, down[i][j]);
                maxLen = max(maxLen, len);
            }
        }

        return maxLen;
    }
};