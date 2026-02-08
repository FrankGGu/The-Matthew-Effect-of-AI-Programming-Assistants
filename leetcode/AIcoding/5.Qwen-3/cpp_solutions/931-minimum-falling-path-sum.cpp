#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int minFallingPathSum(vector<vector<int>>& grid) {
        int n = grid.size();
        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                int minPrev = INT_MAX;
                for (int k = 0; k < n; ++k) {
                    if (k != j) {
                        minPrev = min(minPrev, grid[i-1][k]);
                    }
                }
                grid[i][j] += minPrev;
            }
        }
        int result = INT_MAX;
        for (int j = 0; j < n; ++j) {
            result = min(result, grid[n-1][j]);
        }
        return result;
    }
};