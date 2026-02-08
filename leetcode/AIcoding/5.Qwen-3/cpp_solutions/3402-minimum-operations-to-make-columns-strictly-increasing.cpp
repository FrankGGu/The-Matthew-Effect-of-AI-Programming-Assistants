#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minOperations(vector<vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        int operations = 0;

        for (int j = 1; j < cols; ++j) {
            for (int i = 0; i < rows; ++i) {
                if (grid[i][j] <= grid[i][j-1]) {
                    int needed = grid[i][j-1] + 1;
                    operations += needed - grid[i][j];
                    grid[i][j] = needed;
                }
            }
        }

        return operations;
    }
};