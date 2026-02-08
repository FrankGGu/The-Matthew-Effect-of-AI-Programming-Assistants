#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int largestIsland(vector<vector<int>>& grid) {
        int n = grid.size();
        int m = grid[0].size();
        vector<vector<int>> visited(n, vector<int>(m, 0));
        int islandId = 2;
        unordered_map<int, int> islandSizes;
        int maxIsland = 0;

        function<int(int, int)> dfs = [&](int i, int j) {
            if (i < 0 || i >= n || j < 0 || j >= m || grid[i][j] != 1 || visited[i][j]) {
                return 0;
            }
            visited[i][j] = 1;
            grid[i][j] = islandId;
            return 1 + dfs(i + 1, j) + dfs(i - 1, j) + dfs(i, j + 1) + dfs(i, j - 1);
        };

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (grid[i][j] == 1 && !visited[i][j]) {
                    int size = dfs(i, j);
                    islandSizes[islandId] = size;
                    maxIsland = max(maxIsland, size);
                    islandId++;
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (grid[i][j] == 0) {
                    int size = 1;
                    unordered_map<int, bool> connectedIslands;
                    if (i > 0 && grid[i - 1][j] != 0 && connectedIslands.find(grid[i - 1][j]) == connectedIslands.end()) {
                        size += islandSizes[grid[i - 1][j]];
                        connectedIslands[grid[i - 1][j]] = true;
                    }
                    if (i < n - 1 && grid[i + 1][j] != 0 && connectedIslands.find(grid[i + 1][j]) == connectedIslands.end()) {
                        size += islandSizes[grid[i + 1][j]];
                        connectedIslands[grid[i + 1][j]] = true;
                    }
                    if (j > 0 && grid[i][j - 1] != 0 && connectedIslands.find(grid[i][j - 1]) == connectedIslands.end()) {
                        size += islandSizes[grid[i][j - 1]];
                        connectedIslands[grid[i][j - 1]] = true;
                    }
                    if (j < m - 1 && grid[i][j + 1] != 0 && connectedIslands.find(grid[i][j + 1]) == connectedIslands.end()) {
                        size += islandSizes[grid[i][j + 1]];
                        connectedIslands[grid[i][j + 1]] = true;
                    }
                    maxIsland = max(maxIsland, size);
                }
            }
        }

        return maxIsland;
    }
};