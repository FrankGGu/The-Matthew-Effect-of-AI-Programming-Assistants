#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int projectionArea(vector<vector<int>>& grid) {
        int n = grid.size();
        int xy_area = 0;
        vector<int> x_max(n, 0);
        vector<int> y_max(n, 0);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] > 0) {
                    xy_area++;
                }
                x_max[i] = max(x_max[i], grid[i][j]);
                y_max[j] = max(y_max[j], grid[i][j]);
            }
        }

        int xz_area = 0;
        for (int i = 0; i < n; ++i) {
            xz_area += x_max[i];
        }

        int yz_area = 0;
        for (int i = 0; i < n; ++i) {
            yz_area += y_max[i];
        }

        return xy_area + xz_area + yz_area;
    }
};