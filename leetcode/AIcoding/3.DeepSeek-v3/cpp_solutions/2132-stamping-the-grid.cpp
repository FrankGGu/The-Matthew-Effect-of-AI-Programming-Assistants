class Solution {
public:
    bool possibleToStamp(vector<vector<int>>& grid, int stampHeight, int stampWidth) {
        int m = grid.size();
        int n = grid[0].size();

        vector<vector<int>> prefix(m + 1, vector<int>(n + 1, 0));
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                prefix[i + 1][j + 1] = prefix[i][j + 1] + prefix[i + 1][j] - prefix[i][j] + grid[i][j];
            }
        }

        vector<vector<int>> diff(m + 2, vector<int>(n + 2, 0));
        for (int i = 0; i + stampHeight <= m; ++i) {
            for (int j = 0; j + stampWidth <= n; ++j) {
                int x = i + stampHeight;
                int y = j + stampWidth;
                int sum = prefix[x][y] - prefix[i][y] - prefix[x][j] + prefix[i][j];
                if (sum == 0) {
                    diff[i + 1][j + 1]++;
                    diff[i + 1][y + 1]--;
                    diff[x + 1][j + 1]--;
                    diff[x + 1][y + 1]++;
                }
            }
        }

        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                diff[i][j] += diff[i - 1][j] + diff[i][j - 1] - diff[i - 1][j - 1];
                if (grid[i - 1][j - 1] == 0 && diff[i][j] == 0) {
                    return false;
                }
            }
        }

        return true;
    }
};