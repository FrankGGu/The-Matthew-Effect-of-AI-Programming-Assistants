#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> zigzagTraversal(vector<vector<int>>& grid, int skip) {
        vector<int> result;
        if (grid.empty() || grid[0].empty()) return result;

        int m = grid.size();
        int n = grid[0].size();
        bool reverse = false;

        for (int i = 0; i < m; ++i) {
            if (!reverse) {
                for (int j = 0; j < n; ++j) {
                    if (grid[i][j] != skip) {
                        result.push_back(grid[i][j]);
                    }
                }
            } else {
                for (int j = n - 1; j >= 0; --j) {
                    if (grid[i][j] != skip) {
                        result.push_back(grid[i][j]);
                    }
                }
            }
            reverse = !reverse;
        }

        return result;
    }
};