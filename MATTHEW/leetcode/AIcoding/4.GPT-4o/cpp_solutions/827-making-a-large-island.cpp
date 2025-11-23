class Solution {
public:
    int largestIsland(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<vector<int>> directions = {{1, 0}, {0, 1}, {-1, 0}, {0, -1}};
        unordered_map<int, int> areaMap;
        int islandId = 2, maxArea = 0;

        function<int(int, int, int)> dfs = [&](int x, int y, int id) {
            int area = 1;
            grid[x][y] = id;
            for (auto& dir : directions) {
                int newX = x + dir[0], newY = y + dir[1];
                if (newX >= 0 && newX < n && newY >= 0 && newY < n && grid[newX][newY] == 1) {
                    area += dfs(newX, newY, id);
                }
            }
            return area;
        };

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    int area = dfs(i, j, islandId);
                    areaMap[islandId] = area;
                    maxArea = max(maxArea, area);
                    ++islandId;
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0) {
                    unordered_set<int> neighborIds;
                    for (auto& dir : directions) {
                        int newX = i + dir[0], newY = j + dir[1];
                        if (newX >= 0 && newX < n && newY >= 0 && newY < n && grid[newX][newY] > 1) {
                            neighborIds.insert(grid[newX][newY]);
                        }
                    }
                    int area = 1; // For the current 0 cell
                    for (int id : neighborIds) {
                        area += areaMap[id];
                    }
                    maxArea = max(maxArea, area);
                }
            }
        }

        return maxArea;
    }
};