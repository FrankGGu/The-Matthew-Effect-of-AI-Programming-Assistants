#include <vector>
#include <queue>

using namespace std;

int conveyorBelt(vector<string>& maze) {
    int m = maze.size();
    int n = maze[0].size();

    vector<vector<int>> dist(m, vector<int>(n, -1));
    dist[0][0] = 0;

    priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<tuple<int, int, int>>> pq;
    pq.push({0, 0, 0});

    while (!pq.empty()) {
        auto [d, r, c] = pq.top();
        pq.pop();

        if (d > dist[r][c]) continue;

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};
        char dirs[] = {'^', 'v', '<', '>'};

        for (int i = 0; i < 4; ++i) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                int new_dist = d + (maze[r][c] != dirs[i]);
                if (dist[nr][nc] == -1 || new_dist < dist[nr][nc]) {
                    dist[nr][nc] = new_dist;
                    pq.push({new_dist, nr, nc});
                }
            }
        }
    }

    return dist[m - 1][n - 1];
}