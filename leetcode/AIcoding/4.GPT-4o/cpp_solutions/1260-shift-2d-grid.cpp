#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> shiftGrid(vector<vector<int>>& grid, int k) {
        int rows = grid.size(), cols = grid[0].size();
        vector<vector<int>> result(rows, vector<int>(cols));
        k = k % (rows * cols);

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                int newIndex = (i * cols + j + k) % (rows * cols);
                result[newIndex / cols][newIndex % cols] = grid[i][j];
            }
        }

        return result;
    }
};