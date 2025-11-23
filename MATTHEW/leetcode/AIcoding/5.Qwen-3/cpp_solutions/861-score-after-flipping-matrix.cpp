#include <vector>
#include <algorithm>

class Solution {
public:
    int matrixScore(std::vector<std::vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();

        for (int i = 0; i < rows; ++i) {
            if (grid[i][0] == 0) {
                for (int j = 0; j < cols; ++j) {
                    grid[i][j] ^= 1;
                }
            }
        }

        for (int j = 1; j < cols; ++j) {
            int count = 0;
            for (int i = 0; i < rows; ++i) {
                count += grid[i][j];
            }
            if (count < rows - count) {
                for (int i = 0; i < rows; ++i) {
                    grid[i][j] ^= 1;
                }
            }
        }

        int score = 0;
        for (int i = 0; i < rows; ++i) {
            int rowValue = 0;
            for (int j = 0; j < cols; ++j) {
                rowValue = (rowValue << 1) | grid[i][j];
            }
            score += rowValue;
        }

        return score;
    }
};