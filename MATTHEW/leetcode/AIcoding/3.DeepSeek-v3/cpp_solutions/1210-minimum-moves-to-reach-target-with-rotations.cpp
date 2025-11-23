class Solution {
public:
    int minimumMoves(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<vector<vector<int>>> dist(n, vector<vector<int>>(n, vector<int>(2, -1)));
        queue<tuple<int, int, int>> q;
        dist[0][0][0] = 0;
        q.push({0, 0, 0});

        while (!q.empty()) {
            auto [x, y, dir] = q.front();
            q.pop();

            if (x == n - 1 && y == n - 2 && dir == 0) {
                return dist[x][y][dir];
            }

            if (dir == 0) {
                if (y + 2 < n && grid[x][y + 2] == 0 && dist[x][y + 1][0] == -1) {
                    dist[x][y + 1][0] = dist[x][y][0] + 1;
                    q.push({x, y + 1, 0});
                }
                if (x + 1 < n && grid[x + 1][y] == 0 && grid[x + 1][y + 1] == 0) {
                    if (dist[x + 1][y][0] == -1) {
                        dist[x + 1][y][0] = dist[x][y][0] + 1;
                        q.push({x + 1, y, 0});
                    }
                    if (dist[x][y][1] == -1) {
                        dist[x][y][1] = dist[x][y][0] + 1;
                        q.push({x, y, 1});
                    }
                }
            } else {
                if (x + 2 < n && grid[x + 2][y] == 0 && dist[x + 1][y][1] == -1) {
                    dist[x + 1][y][1] = dist[x][y][1] + 1;
                    q.push({x + 1, y, 1});
                }
                if (y + 1 < n && grid[x][y + 1] == 0 && grid[x + 1][y + 1] == 0) {
                    if (dist[x][y + 1][1] == -1) {
                        dist[x][y + 1][1] = dist[x][y][1] + 1;
                        q.push({x, y + 1, 1});
                    }
                    if (dist[x][y][0] == -1) {
                        dist[x][y][0] = dist[x][y][1] + 1;
                        q.push({x, y, 0});
                    }
                }
            }
        }

        return -1;
    }
};