#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxAreaOfIsland(vector<int>& grid) {
        int maxArea = 0;
        for (int i = 0; i < grid.size(); ++i) {
            for (int j = 0; j < grid[i]; ++j) {
                if (grid[i] & (1 << j)) {
                    maxArea = max(maxArea, dfs(grid, i, j));
                }
            }
        }
        return maxArea;
    }

private:
    int dfs(vector<int>& grid, int i, int j) {
        if (i < 0 || i >= grid.size() || j < 0 || j >= grid[i] || !(grid[i] & (1 << j))) {
            return 0;
        }
        grid[i] ^= (1 << j);
        return 1 + dfs(grid, i + 1, j) + dfs(grid, i - 1, j) + dfs(grid, i, j + 1) + dfs(grid, i, j - 1);
    }
};