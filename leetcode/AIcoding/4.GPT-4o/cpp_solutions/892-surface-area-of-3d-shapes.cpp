class Solution {
public:
    int surfaceArea(vector<vector<int>>& grid) {
        int totalArea = 0;
        int n = grid.size();
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] > 0) {
                    totalArea += 2; // top and bottom
                    totalArea += 4 * grid[i][j]; // sides
                    if (i > 0) totalArea -= min(grid[i][j], grid[i-1][j]) * 2; // subtract overlapping area with the block above
                    if (j > 0) totalArea -= min(grid[i][j], grid[i][j-1]) * 2; // subtract overlapping area with the block on the left
                }
            }
        }
        return totalArea;
    }
};