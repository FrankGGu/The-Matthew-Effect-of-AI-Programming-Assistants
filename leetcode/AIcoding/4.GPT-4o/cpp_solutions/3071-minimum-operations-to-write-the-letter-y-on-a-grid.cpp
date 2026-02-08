class Solution {
public:
    int minimumOperations(vector<vector<char>>& grid) {
        int m = grid.size(), n = grid[0].size();
        int ans = INT_MAX;

        for (int r1 = 0; r1 < m; ++r1) {
            for (int c1 = 0; c1 < n; ++c1) {
                for (int r2 = r1 + 1; r2 < m; ++r2) {
                    for (int c2 = 0; c2 < n; ++c2) {
                        int operations = 0;
                        for (int i = 0; i < m; ++i) {
                            for (int j = 0; j < n; ++j) {
                                if (i == r1 && j == c1) {
                                    if (grid[i][j] != 'Y') operations++;
                                } else if (i == r2 && j == c2) {
                                    if (grid[i][j] != 'Y') operations++;
                                } else if (i == r1 + 1 && j == c1) {
                                    if (grid[i][j] != 'Y') operations++;
                                } else {
                                    if (grid[i][j] != '.') operations++;
                                }
                            }
                        }
                        ans = min(ans, operations);
                    }
                }
            }
        }

        return ans == INT_MAX ? -1 : ans;
    }
};