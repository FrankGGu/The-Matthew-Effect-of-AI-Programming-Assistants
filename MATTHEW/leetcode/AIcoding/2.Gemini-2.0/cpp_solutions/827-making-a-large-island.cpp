#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int largestIsland(vector<vector<int>>& grid) {
        int n = grid.size();
        int islandId = 2;
        vector<int> islandSizes = {0, 0, 0};

        function<int(int, int)> dfs = [&](int i, int j) {
            if (i < 0 || i >= n || j < 0 || j >= n || grid[i][j] != 1) {
                return 0;
            }
            grid[i][j] = islandId;
            return 1 + dfs(i + 1, j) + dfs(i - 1, j) + dfs(i, j + 1) + dfs(i, j - 1);
        };

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    int size = dfs(i, j);
                    islandSizes.push_back(size);
                    islandId++;
                }
            }
        }

        int maxIsland = 0;
        if (islandSizes.size() == 3) {
            for(int i = 0; i < n; ++i){
                for(int j = 0; j < n; ++j){
                    if(grid[i][j] == 0){
                        maxIsland = 1;
                        break;
                    }
                }
                if(maxIsland == 1) break;
            }
        }

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0) {
                    unordered_set<int> neighbors;
                    if (i > 0) neighbors.insert(grid[i - 1][j]);
                    if (i < n - 1) neighbors.insert(grid[i + 1][j]);
                    if (j > 0) neighbors.insert(grid[i][j - 1]);
                    if (j < n - 1) neighbors.insert(grid[i][j + 1]);

                    int currentIsland = 1;
                    for (int neighbor : neighbors) {
                        currentIsland += islandSizes[neighbor];
                    }
                    maxIsland = max(maxIsland, currentIsland);
                }
            }
        }

        if(maxIsland == 0){
            for(int size : islandSizes){
                maxIsland = max(maxIsland, size);
            }
        }

        if(maxIsland == 1){
            bool all_ones = true;
            for(int i = 0; i < n; ++i){
                for(int j = 0; j < n; ++j){
                    if(grid[i][j] == 0){
                        all_ones = false;
                        break;
                    }
                }
                if(!all_ones) break;
            }

            if(all_ones) return n * n;
        }

        return maxIsland == 0 ? n * n : maxIsland;
    }
};