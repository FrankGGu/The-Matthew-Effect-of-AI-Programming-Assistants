class Solution {
public:
    vector<vector<int>> constructGrid(int m, int n) {
        vector<vector<int>> grid(m, vector<int>(n, 0));
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                grid[i][j] = i * n + j + 1;
            }
        }
        return grid;
    }
};