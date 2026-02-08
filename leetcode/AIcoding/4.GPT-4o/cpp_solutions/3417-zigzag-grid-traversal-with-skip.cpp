class Solution {
public:
    vector<int> zigzagMatrix(vector<vector<int>>& grid, int r, int c) {
        vector<int> result;
        int rows = grid.size(), cols = grid[0].size();
        bool leftToRight = true;

        for (int i = 0; i < rows; ++i) {
            if (leftToRight) {
                for (int j = 0; j < cols; ++j) {
                    result.push_back(grid[i][j]);
                }
            } else {
                for (int j = cols - 1; j >= 0; --j) {
                    result.push_back(grid[i][j]);
                }
            }
            leftToRight = !leftToRight;
        }

        return result;
    }
};