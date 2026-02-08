#include <vector>
#include <queue>
#include <climits>
#include <unordered_map>
using namespace std;

class Solution {
public:
    int minimumMoves(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<vector<int>> dist(n, vector<int>(n, INT_MAX));
        unordered_map<int, pair<int, int>> portals;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] > 0) {
                    int idx = i * n + j;
                    int target = grid[i][j] - 1;
                    int ti = target / n;
                    int tj = target % n;
                    portals[idx] = {ti, tj};
                }
            }
        }

        queue<pair<int, int>> q;
        dist[0][0] = 0;
        q.push({0, 0});

        vector<int> dx = {1, -1, 0, 0};
        vector<int> dy = {0, 0, 1, -1};

        while (!q.empty()) {
            auto [x, y] = q.front();
            q.pop();
            int idx = x * n + y;
            if (portals.find(idx) != portals.end()) {
                auto [nx, ny] = portals[idx];
                if (dist[nx][ny] > dist[x][y]) {
                    dist[nx][ny] = dist[x][y];
                    q.push({nx, ny});
                }
            } else {
                for (int d = 0; d < 4; d++) {
                    int nx = x + dx[d];
                    int ny = y + dy[d];
                    if (nx >= 0 && nx < n && ny >= 0 && ny < n && dist[nx][ny] > dist[x][y] + 1) {
                        dist[nx][ny] = dist[x][y] + 1;
                        q.push({nx, ny});
                    }
                }
            }
        }

        return dist[n-1][n-1] == INT_MAX ? -1 : dist[n-1][n-1];
    }
};