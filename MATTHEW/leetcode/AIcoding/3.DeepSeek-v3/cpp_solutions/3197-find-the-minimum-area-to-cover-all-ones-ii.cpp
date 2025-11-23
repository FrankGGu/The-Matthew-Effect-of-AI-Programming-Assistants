class Solution {
public:
    int minimumArea(vector<vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return 0;
        int n = grid[0].size();
        if (n == 0) return 0;

        int min_row = m, max_row = -1;
        int min_col = n, max_col = -1;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    if (i < min_row) min_row = i;
                    if (i > max_row) max_row = i;
                    if (j < min_col) min_col = j;
                    if (j > max_col) max_col = j;
                }
            }
        }

        if (max_row == -1) return 0;

        return (max_row - min_row + 1) * (max_col - min_col + 1);
    }
};