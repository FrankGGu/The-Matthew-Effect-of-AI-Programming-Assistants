#include <vector>
#include <queue>

using namespace std;

int gridTeleportationTraversal(vector<vector<int>>& grid, int teleportCost) {
    int m = grid.size();
    int n = grid[0].size();

    vector<vector<int>> dist(m, vector<int>(n, -1));
    queue<pair<int, int>> q;

    q.push({0, 0});
    dist[0][0] = 0;

    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    while (!q.empty()) {
        int x = q.front().first;
        int y = q.front().second;
        q.pop();

        for (int i = 0; i < 4; ++i) {
            int nx = x + dx[i];
            int ny = y + dy[i];

            if (nx >= 0 && nx < m && ny >= 0 && ny < n && dist[nx][ny] == -1) {
                dist[nx][ny] = dist[x][y] + grid[nx][ny];
                q.push({nx, ny});
            }
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (dist[i][j] == -1) {
                    dist[i][j] = dist[x][y] + teleportCost + grid[i][j];
                    q.push({i, j});
                }
            }
        }
    }

    return dist[m - 1][n - 1];
}