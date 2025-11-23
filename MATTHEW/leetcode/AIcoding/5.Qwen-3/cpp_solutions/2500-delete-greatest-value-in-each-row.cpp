#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int deleteGreatestValue(vector<vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();

        for (int i = 0; i < rows; ++i) {
            sort(grid[i].begin(), grid[i].end());
        }

        int result = 0;
        for (int j = 0; j < cols; ++j) {
            int maxVal = 0;
            for (int i = 0; i < rows; ++i) {
                maxVal = max(maxVal, grid[i][j]);
            }
            result += maxVal;
        }

        return result;
    }
};