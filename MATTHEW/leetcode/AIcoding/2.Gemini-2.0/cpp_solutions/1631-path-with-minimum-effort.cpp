#include <vector>
#include <queue>
#include <climits>

using namespace std;

int minimumEffortPath(vector<vector<int>>& heights) {
    int m = heights.size();
    int n = heights[0].size();

    vector<vector<int>> dist(m, vector<int>(n, INT_MAX));
    dist[0][0] = 0;

    priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<tuple<int, int, int>>> pq;
    pq.push({0, 0, 0});

    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    while (!pq.empty()) {
        auto [effort, x, y] = pq.top();
        pq.pop();

        if (effort > dist[x][y]) {
            continue;
        }

        if (x == m - 1 && y == n - 1) {
            return effort;
        }

        for (int i = 0; i < 4; ++i) {
            int nx = x + dx[i];
            int ny = y + dy[i];

            if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                int newEffort = max(effort, abs(heights[x][y] - heights[nx][ny]));
                if (newEffort < dist[nx][ny]) {
                    dist[nx][ny] = newEffort;
                    pq.push({newEffort, nx, ny});
                }
            }
        }
    }

    return dist[m - 1][n - 1];
}