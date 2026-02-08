#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int surfaceArea(vector<vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        int area = 0;
        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] > 0) {
                    area += 2;
                    int up = (i > 0) ? grid[i-1][j] : 0;
                    int down = (i < rows - 1) ? grid[i+1][j] : 0;
                    int left = (j > 0) ? grid[i][j-1] : 0;
                    int right = (j < cols - 1) ? grid[i][j+1] : 0;
                    area += max(0, grid[i][j] - up);
                    area += max(0, grid[i][j] - down);
                    area += max(0, grid[i][j] - left);
                    area += max(0, grid[i][j] - right);
                }
            }
        }
        return area;
    }
};