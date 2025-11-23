#include <vector>

using namespace std;

class Solution {
public:
    int surfaceArea(vector<vector<int>>& grid) {
        int n = grid.size();
        int area = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] > 0) {
                    area += 2;
                    area += grid[i][j];
                    if (i > 0) {
                        area -= min(grid[i][j], grid[i - 1][j]);
                    }
                    if (i < n - 1) {
                        area -= min(grid[i][j], grid[i + 1][j]);
                    }
                    if (j > 0) {
                        area -= min(grid[i][j], grid[i][j - 1]);
                    }
                    if (j < n - 1) {
                        area -= min(grid[i][j], grid[i][j + 1]);
                    }

                }
            }
        }

        return area;
    }
};