#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int deleteGreatestValue(vector<vector<int>>& grid) {
        int result = 0;
        int rows = grid.size();
        int cols = grid[0].size();

        for (int j = 0; j < cols; ++j) {
            int maxVal = 0;
            for (int i = 0; i < rows; ++i) {
                maxVal = max(maxVal, grid[i][j]);
            }
            result += maxVal;
            for (int i = 0; i < rows; ++i) {
                grid[i][j] = 0;
            }
        }

        return result;
    }
};