class Solution {
public:
    vector<vector<int>> largestLocal(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<vector<int>> result(n - 2, vector<int>(n - 2));

        for (int i = 0; i < n - 2; ++i) {
            for (int j = 0; j < n - 2; ++j) {
                int maxValue = 0;
                for (int x = 0; x < 3; ++x) {
                    for (int y = 0; y < 3; ++y) {
                        maxValue = max(maxValue, grid[i + x][j + y]);
                    }
                }
                result[i][j] = maxValue;
            }
        }

        return result;
    }
};