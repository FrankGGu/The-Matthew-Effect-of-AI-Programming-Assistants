#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    bool hasValidPath(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        vector<vector<int>> map = {
            {-1, -1, 0, 1},
            {-1, -1, 3, 2},
            {3, 2, -1, -1},
            {1, 0, -1, -1}
        };

        vector<vector<bool>> visited(m, vector<bool>(n, false));
        queue<pair<int, int>> q;
        q.push({0, 0});
        visited[0][0] = true;

        while (!q.empty()) {
            auto [x, y] = q.front();
            q.pop();
            if (x == m - 1 && y == n - 1) return true;
            int type = grid[x][y];
            for (int i = 0; i < 4; ++i) {
                int dx = directions[i][0];
                int dy = directions[i][1];
                int nx = x + dx;
                int ny = y + dy;
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny]) {
                    int neighborType = grid[nx][ny];
                    int dir = map[type][i];
                    if (dir != -1 && map[neighborType][dir] != -1) {
                        visited[nx][ny] = true;
                        q.push({nx, ny});
                    }
                }
            }
        }
        return false;
    }
};