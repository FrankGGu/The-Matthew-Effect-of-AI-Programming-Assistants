#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int shortestPath(vector<vector<int>>& grid, int k) {
        int m = grid.size();
        int n = grid[0].size();

        if (m == 1 && n == 1) return 0;

        vector<vector<vector<int>>> visited(m, vector<vector<int>>(n, vector<int>(k + 1, -1)));

        queue<tuple<int, int, int, int>> q;
        q.push({0, 0, k, 0});
        visited[0][0][k] = 0;

        int dx[] = {0, 0, 1, -1};
        int dy[] = {1, -1, 0, 0};

        while (!q.empty()) {
            auto [x, y, obs, dist] = q.front();
            q.pop();

            for (int i = 0; i < 4; ++i) {
                int nx = x + dx[i];
                int ny = y + dy[i];

                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    if (grid[nx][ny] == 0) {
                        if (visited[nx][ny][obs] == -1) {
                            visited[nx][ny][obs] = dist + 1;
                            if (nx == m - 1 && ny == n - 1) return dist + 1;
                            q.push({nx, ny, obs, dist + 1});
                        }
                    } else {
                        if (obs > 0 && visited[nx][ny][obs - 1] == -1) {
                            visited[nx][ny][obs - 1] = dist + 1;
                            if (nx == m - 1 && ny == n - 1) return dist + 1;
                            q.push({nx, ny, obs - 1, dist + 1});
                        }
                    }
                }
            }
        }

        return -1;
    }
};