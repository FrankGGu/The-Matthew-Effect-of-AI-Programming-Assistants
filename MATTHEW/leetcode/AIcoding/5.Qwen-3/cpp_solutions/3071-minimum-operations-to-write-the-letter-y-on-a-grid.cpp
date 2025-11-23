#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int minimumOperationsToWriteY(const vector<vector<char>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        int operations = 0;

        int midRow = rows / 2;
        int midCol = cols / 2;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if ((i <= midRow && abs(i - midRow) == abs(j - midCol)) || (i > midRow && j == midCol)) {
                    if (grid[i][j] != 'y') {
                        ++operations;
                    }
                } else {
                    if (grid[i][j] != 'o') {
                        ++operations;
                    }
                }
            }
        }

        return operations;
    }
};