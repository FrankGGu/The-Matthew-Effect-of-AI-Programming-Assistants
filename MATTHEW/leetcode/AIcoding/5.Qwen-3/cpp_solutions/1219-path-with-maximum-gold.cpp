#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int getMaximumGold(vector<vector<int>>& grid) {
        int maxGold = 0;
        for (int i = 0; i < grid.size(); ++i) {
            for (int j = 0; j < grid[0].size(); ++j) {
                if (grid[i][j] != 0) {
                    maxGold = max(maxGold, dfs(grid, i, j));
                }
            }
        }
        return maxGold;
    }

private:
    int dfs(vector<vector<int>>& grid, int i, int j) {
        int gold = grid[i][j];
        int temp = grid[i][j];
        grid[i][j] = 0;
        int maxNext = 0;
        int dx[] = {-1, 1, 0, 0};
        int dy[] = {0, 0, -1, 1};
        for (int k = 0; k < 4; ++k) {
            int x = i + dx[k];
            int y = j + dy[k];
            if (x >= 0 && x < grid.size() && y >= 0 && y < grid[0].size() && grid[x][y] != 0) {
                maxNext = max(maxNext, dfs(grid, x, y));
            }
        }
        grid[i][j] = temp;
        return gold + maxNext;
    }
};