#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int projectionArea(vector<vector<int>>& grid) {
        int xy = 0;
        int xz = 0;
        int yz = 0;

        for (int i = 0; i < grid.size(); ++i) {
            for (int j = 0; j < grid[i].size(); ++j) {
                if (grid[i][j] > 0) {
                    ++xy;
                }
                xz = max(xz, grid[i][j]);
                yz = max(yz, grid[i][j]);
            }
        }

        return xy + xz + yz;
    }
};