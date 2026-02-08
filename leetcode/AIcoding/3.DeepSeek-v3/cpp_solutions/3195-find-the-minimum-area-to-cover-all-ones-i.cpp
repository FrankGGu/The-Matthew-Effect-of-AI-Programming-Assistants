class Solution {
public:
    int minArea(vector<vector<int>>& grid, int x, int y) {
        int min_row = x, max_row = x;
        int min_col = y, max_col = y;

        for (int i = 0; i < grid.size(); ++i) {
            for (int j = 0; j < grid[0].size(); ++j) {
                if (grid[i][j] == 1) {
                    min_row = min(min_row, i);
                    max_row = max(max_row, i);
                    min_col = min(min_col, j);
                    max_col = max(max_col, j);
                }
            }
        }

        return (max_row - min_row + 1) * (max_col - min_col + 1);
    }
};