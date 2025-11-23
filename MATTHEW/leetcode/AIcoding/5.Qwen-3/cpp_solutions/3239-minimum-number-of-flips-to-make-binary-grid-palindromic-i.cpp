#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minFlips(vector<vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        int flips = 0;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols / 2; ++j) {
                int opposite = cols - 1 - j;
                if (grid[i][j] != grid[i][opposite]) {
                    ++flips;
                }
            }
        }

        for (int j = 0; j < cols; ++j) {
            for (int i = 0; i < rows / 2; ++i) {
                int opposite = rows - 1 - i;
                if (grid[i][j] != grid[opposite][j]) {
                    ++flips;
                }
            }
        }

        return flips;
    }
};