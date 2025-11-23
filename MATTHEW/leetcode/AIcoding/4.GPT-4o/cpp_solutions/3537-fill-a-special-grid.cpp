class Solution {
public:
    vector<vector<int>> fillGrid(int n) {
        vector<vector<int>> grid(n, vector<int>(n, 0));
        int num = 1;
        for (int i = 0; i < n; i += 2) {
            for (int j = 0; j < n; j += 2) {
                grid[i][j] = num++;
                grid[i][j + 1] = num++;
                grid[i + 1][j] = num++;
                grid[i + 1][j + 1] = num++;
            }
        }
        return grid;
    }
};