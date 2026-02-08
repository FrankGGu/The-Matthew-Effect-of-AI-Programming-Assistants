#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> findFarmland(vector<vector<int>>& land) {
        int m = land.size();
        int n = land[0].size();
        vector<vector<int>> res;

        function<void(int, int)> dfs = [&](int r, int c) {
            if (r < 0 || r >= m || c < 0 || c >= n || land[r][c] == 0) {
                return;
            }
            land[r][c] = 0;
            dfs(r + 1, c);
            dfs(r, c + 1);
        };

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (land[i][j] == 1) {
                    int row_end = i;
                    int col_end = j;

                    function<void(int, int)> findEnd = [&](int r, int c) {
                        if (r < 0 || r >= m || c < 0 || c >= n || land[r][c] == 0) {
                            return;
                        }
                        land[r][c] = 0;
                        row_end = max(row_end, r);
                        col_end = max(col_end, c);
                        findEnd(r + 1, c);
                        findEnd(r, c + 1);
                    };

                    vector<vector<int>> tempLand = land;

                    findEnd(i,j);

                    land = tempLand;

                    function<void(int, int)> resetLand = [&](int r, int c) {
                        if (r < 0 || r >= m || c < 0 || c >= n || tempLand[r][c] == 0) {
                            return;
                        }
                        tempLand[r][c] = 0;
                        resetLand(r + 1, c);
                        resetLand(r, c + 1);
                    };

                    resetLand(i,j);
                    land = tempLand;

                    int r_end = i;
                    int c_end = j;

                    while(r_end + 1 < m && land[r_end+1][j] == 1)
                        r_end++;
                    while(c_end + 1 < n && land[i][c_end+1] == 1)
                        c_end++;

                    function<void(int, int)> findRowEnd = [&](int r, int c) {
                        if (r < 0 || r >= m || c < 0 || c >= n || land[r][c] == 0) {
                            return;
                        }
                        land[r][c] = 0;
                        r_end = max(r_end, r);

                        findRowEnd(r + 1, c);
                        findRowEnd(r, c + 1);
                    };

                    function<void(int, int)> findColEnd = [&](int r, int c) {
                        if (r < 0 || r >= m || c < 0 || c >= n || land[r][c] == 0) {
                            return;
                        }
                        land[r][c] = 0;

                        c_end = max(c_end, c);
                        findColEnd(r + 1, c);
                        findColEnd(r, c + 1);
                    };

                    while(r_end + 1 < m && land[r_end+1][j] == 1)
                        r_end++;
                    while(c_end + 1 < n && land[i][c_end+1] == 1)
                        c_end++;

                    int final_row_end = i;
                    int final_col_end = j;

                    function<void(int, int)> findFinalEnd = [&](int r, int c) {
                        if (r < 0 || r >= m || c < 0 || c >= n || land[r][c] == 0) {
                            return;
                        }
                        land[r][c] = 0;
                        final_row_end = max(final_row_end, r);
                        final_col_end = max(final_col_end, c);
                        findFinalEnd(r + 1, c);
                        findFinalEnd(r, c + 1);
                    };

                    tempLand = land;
                    findFinalEnd(i,j);
                    land = tempLand;

                    res.push_back({i, j, final_row_end, final_col_end});

                    dfs(i, j);
                }
            }
        }
        return res;
    }
};