class Solution {
public:
    int largest1BorderedSquare(vector<vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return 0;
        int n = grid[0].size();
        vector<vector<int>> left(m, vector<int>(n, 0));
        vector<vector<int>> top(m, vector<int>(n, 0));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    left[i][j] = (j == 0) ? 1 : left[i][j-1] + 1;
                    top[i][j] = (i == 0) ? 1 : top[i-1][j] + 1;
                }
            }
        }

        int maxLen = 0;
        for (int i = m - 1; i >= 0; --i) {
            for (int j = n - 1; j >= 0; --j) {
                int len = min(left[i][j], top[i][j]);
                while (len > maxLen) {
                    if (left[i - len + 1][j] >= len && top[i][j - len + 1] >= len) {
                        maxLen = len;
                        break;
                    }
                    len--;
                }
            }
        }

        return maxLen * maxLen;
    }
};