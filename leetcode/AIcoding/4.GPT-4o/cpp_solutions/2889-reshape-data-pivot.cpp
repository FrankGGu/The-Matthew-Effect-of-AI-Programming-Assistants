class Solution {
public:
    vector<vector<int>> pivotGrid(vector<vector<int>>& grid, int row, int col) {
        int rows = grid.size(), cols = grid[0].size();
        vector<vector<int>> result(rows, vector<int>(cols, 0));

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                result[i][j] = grid[(i + row) % rows][(j + col) % cols];
            }
        }
        return result;
    }
};