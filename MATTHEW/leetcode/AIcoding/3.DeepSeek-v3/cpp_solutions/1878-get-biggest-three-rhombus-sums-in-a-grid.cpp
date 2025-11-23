class Solution {
public:
    vector<int> getBiggestThree(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        set<int> sums;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                sums.insert(grid[i][j]);
                int maxLen = min({i, m - 1 - i, j, n - 1 - j});
                for (int l = 1; l <= maxLen; ++l) {
                    int sum = 0;
                    int x = i - l, y = j;
                    for (int k = 0; k < l; ++k) {
                        sum += grid[x + k][y + k];
                    }
                    x = i, y = j + l;
                    for (int k = 0; k < l; ++k) {
                        sum += grid[x + k][y - k];
                    }
                    x = i + l, y = j;
                    for (int k = 0; k < l; ++k) {
                        sum += grid[x - k][y - k];
                    }
                    x = i, y = j - l;
                    for (int k = 0; k < l; ++k) {
                        sum += grid[x - k][y + k];
                    }
                    sums.insert(sum);
                }
            }
        }

        vector<int> res;
        for (auto it = sums.rbegin(); it != sums.rend(); ++it) {
            res.push_back(*it);
            if (res.size() == 3) break;
        }
        return res;
    }
};