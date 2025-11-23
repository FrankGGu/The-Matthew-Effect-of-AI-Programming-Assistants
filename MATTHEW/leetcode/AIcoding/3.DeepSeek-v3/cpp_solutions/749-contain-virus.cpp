class Solution {
public:
    int containVirus(vector<vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return 0;
        int n = grid[0].size();
        int res = 0;
        while (true) {
            vector<vector<int>> visited(m, vector<int>(n, 0));
            vector<unordered_set<int>> regions;
            vector<unordered_set<int>> frontiers;
            vector<int> perimeters;
            for (int i = 0; i < m; ++i) {
                for (int j = 0; j < n; ++j) {
                    if (grid[i][j] == 1 && visited[i][j] == 0) {
                        regions.push_back(unordered_set<int>());
                        frontiers.push_back(unordered_set<int>());
                        perimeters.push_back(0);
                        dfs(grid, visited, i, j, regions.back(), frontiers.back(), perimeters.back());
                    }
                }
            }
            if (regions.empty()) break;
            int max_idx = 0;
            for (int i = 0; i < frontiers.size(); ++i) {
                if (frontiers[i].size() > frontiers[max_idx].size()) {
                    max_idx = i;
                }
            }
            res += perimeters[max_idx];
            for (int i = 0; i < regions.size(); ++i) {
                if (i == max_idx) {
                    for (int key : regions[i]) {
                        int x = key / n, y = key % n;
                        grid[x][y] = -1;
                    }
                } else {
                    for (int key : regions[i]) {
                        int x = key / n, y = key % n;
                        for (auto& dir : dirs) {
                            int nx = x + dir[0], ny = y + dir[1];
                            if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] == 0) {
                                grid[nx][ny] = 1;
                            }
                        }
                    }
                }
            }
        }
        return res;
    }
private:
    vector<vector<int>> dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    void dfs(vector<vector<int>>& grid, vector<vector<int>>& visited, int i, int j, unordered_set<int>& region, unordered_set<int>& frontier, int& perimeter) {
        int m = grid.size(), n = grid[0].size();
        visited[i][j] = 1;
        region.insert(i * n + j);
        for (auto& dir : dirs) {
            int x = i + dir[0], y = j + dir[1];
            if (x >= 0 && x < m && y >= 0 && y < n) {
                if (grid[x][y] == 1 && visited[x][y] == 0) {
                    dfs(grid, visited, x, y, region, frontier, perimeter);
                } else if (grid[x][y] == 0) {
                    frontier.insert(x * n + y);
                    perimeter++;
                }
            }
        }
    }
};