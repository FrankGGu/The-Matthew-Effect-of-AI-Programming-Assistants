#include <vector>
#include <queue>

using namespace std;

int minimumMoves(vector<string>& grid) {
    int n = grid.size();
    vector<vector<int>> dist(n, vector<int>(n, -1));
    queue<pair<int, int>> q;

    if (grid[0][0] == 'X' || grid[n - 1][n - 1] == 'X') {
        return -1;
    }

    dist[0][0] = 0;
    q.push({0, 0});

    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    while (!q.empty()) {
        int x = q.front().first;
        int y = q.front().second;
        q.pop();

        for (int i = 0; i < 4; ++i) {
            int nx = x + dx[i];
            int ny = y + dy[i];

            if (nx >= 0 && nx < n && ny >= 0 && ny < n && grid[nx][ny] == '.' && dist[nx][ny] == -1) {
                dist[nx][ny] = dist[x][y] + 1;
                q.push({nx, ny});
            }
        }
    }

    return dist[n - 1][n - 1];
}