#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> shiftGrid(vector<vector<int>>& grid, int k) {
        int m = grid.size();
        int n = grid[0].size();
        k %= (m * n);

        vector<vector<int>> result(m, vector<int>(n));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int new_index = (i * n + j + k) % (m * n);
                int new_row = new_index / n;
                int new_col = new_index % n;
                result[new_row][new_col] = grid[i][j];
            }
        }

        return result;
    }
};