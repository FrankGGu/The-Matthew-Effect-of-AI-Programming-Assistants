#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> findBall(vector<vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        vector<int> result(cols);

        for (int col = 0; col < cols; ++col) {
            int currentCol = col;
            for (int row = 0; row < rows; ++row) {
                int nextCol = currentCol + grid[row][currentCol];
                if (nextCol < 0 || nextCol >= cols) {
                    currentCol = -1;
                    break;
                }
                currentCol = nextCol;
            }
            result[col] = currentCol;
        }

        return result;
    }
};