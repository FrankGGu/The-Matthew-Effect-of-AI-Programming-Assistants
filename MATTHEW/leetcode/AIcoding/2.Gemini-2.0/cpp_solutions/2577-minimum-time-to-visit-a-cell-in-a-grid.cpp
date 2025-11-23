#include <vector>
#include <queue>

using namespace std;

int minimumTime(vector<vector<int>>& grid) {
    int m = grid.size();
    int n = grid[0].size();

    if (grid[0][1] > 1 && grid[1][0] > 1) {
        return -1;
    }

    vector<vector<int>> dist(m, vector<int>(n, 1e9));
    dist[0][0] = 0;

    priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<tuple<int, int, int>>> pq;
    pq.push({0, 0, 0});

    vector<pair<int, int>> directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    while (!pq.empty()) {
        auto [d, r, c] = pq.top();
        pq.pop();

        if (d > dist[r][c]) {
            continue;
        }

        for (auto [dr, dc] : directions) {
            int nr = r + dr;
            int nc = c + dc;

            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                int wait_time = 0;
                if (grid[nr][nc] > d + 1) {
                    wait_time = grid[nr][nc] - (d + 1);
                    if (wait_time % 2 == 0) wait_time++;
                    else wait_time = wait_time;
                }

                int new_dist = d + 1 + wait_time;

                if (new_dist < dist[nr][nc]) {
                    dist[nr][nc] = new_dist;
                    pq.push({new_dist, nr, nc});
                }
            }
        }
    }

    if (dist[m - 1][n - 1] == 1e9) {
        return -1;
    }

    return dist[m - 1][n - 1];
}