#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int minFallingPathSum(vector<vector<int>>& grid) {
        int n = grid.size();
        for (int i = 1; i < n; ++i) {
            int min1 = INT_MAX, min2 = INT_MAX;
            for (int j = 0; j < n; ++j) {
                if (grid[i-1][j] < min1) {
                    min2 = min1;
                    min1 = grid[i-1][j];
                } else if (grid[i-1][j] < min2) {
                    min2 = grid[i-1][j];
                }
            }
            for (int j = 0; j < n; ++j) {
                if (grid[i-1][j] == min1) {
                    grid[i][j] += min2;
                } else {
                    grid[i][j] += min1;
                }
            }
        }
        return *min_element(grid.back().begin(), grid.back().end());
    }
};