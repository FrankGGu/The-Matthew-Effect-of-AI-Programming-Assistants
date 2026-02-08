class Solution {
public:
    int reclaimPoints(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        int total_points = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                total_points += grid[i][j];
            }
        }

        return total_points;
    }
};