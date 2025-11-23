#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumObstacles(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        vector<vector<int>> dist(m, vector<int>(n, 1e9));
        dist[0][0] = 0;

        priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<tuple<int, int, int>>> pq;
        pq.emplace(0, 0, 0);

        int dx[] = {0, 0, 1, -1};
        int dy[] = {1, -1, 0, 0};

        while (!pq.empty()) {
            auto [d, x, y] = pq.top();
            pq.pop();

            if (d > dist[x][y]) continue;

            for (int i = 0; i < 4; ++i) {
                int nx = x + dx[i];
                int ny = y + dy[i];

                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    int weight = grid[nx][ny];
                    if (dist[nx][ny] > dist[x][y] + weight) {
                        dist[nx][ny] = dist[x][y] + weight;
                        pq.emplace(dist[nx][ny], nx, ny);
                    }
                }
            }
        }

        return dist[m - 1][n - 1];
    }
};