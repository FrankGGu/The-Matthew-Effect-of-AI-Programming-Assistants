class Solution {
public:
    int deleteGreatestValue(vector<vector<int>>& grid) {
        for (auto& row : grid) {
            sort(row.begin(), row.end());
        }
        int res = 0;
        for (int j = 0; j < grid[0].size(); ++j) {
            int max_val = 0;
            for (int i = 0; i < grid.size(); ++i) {
                max_val = max(max_val, grid[i][j]);
            }
            res += max_val;
        }
        return res;
    }
};