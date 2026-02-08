#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int largestIsland(vector<vector<int>>& grid) {
        int n = grid.size();
        int m = grid[0].size();
        unordered_map<int, int> areaMap;
        int maxArea = 0;
        int dir[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (grid[i][j] == 1) {
                    int id = i * m + j + 2;
                    int area = bfs(grid, i, j, id, dir, n, m);
                    areaMap[id] = area;
                    maxArea = max(maxArea, area);
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (grid[i][j] == 0) {
                    int total = 1;
                    unordered_set<int> neighborIds;
                    for (int k = 0; k < 4; ++k) {
                        int ni = i + dir[k][0];
                        int nj = j + dir[k][1];
                        if (ni >= 0 && ni < n && nj >= 0 && nj < m && grid[ni][nj] != 0) {
                            int id = ni * m + nj + 2;
                            neighborIds.insert(id);
                        }
                    }
                    for (auto id : neighborIds) {
                        total += areaMap[id];
                    }
                    maxArea = max(maxArea, total);
                }
            }
        }

        return maxArea;
    }

private:
    int bfs(vector<vector<int>>& grid, int i, int j, int id, int dir[4][2], int n, int m) {
        queue<pair<int, int>> q;
        q.push({i, j});
        grid[i][j] = id;
        int area = 1;

        while (!q.empty()) {
            auto [x, y] = q.front();
            q.pop();

            for (int k = 0; k < 4; ++k) {
                int nx = x + dir[k][0];
                int ny = y + dir[k][1];
                if (nx >= 0 && nx < n && ny >= 0 && ny < m && grid[nx][ny] == 1) {
                    grid[nx][ny] = id;
                    q.push({nx, ny});
                    area++;
                }
            }
        }

        return area;
    }
};