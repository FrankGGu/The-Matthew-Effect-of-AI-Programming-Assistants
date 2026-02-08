#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>
#include <utility>

using namespace std;

class Solution {
public:
    int bfs(int n, vector<vector<int>>& grid, vector<vector<int>>& teleport) {
        vector<vector<int>> dist(n, vector<int>(n, -1));
        queue<pair<int, int>> q;
        q.push({0, 0});
        dist[0][0] = 0;

        int dx[] = {-1, 0, 1, 0};
        int dy[] = {0, 1, 0, -1};

        while (!q.empty()) {
            auto [x, y] = q.front();
            q.pop();

            for (int i = 0; i < 4; ++i) {
                int nx = x + dx[i];
                int ny = y + dy[i];

                if (nx >= 0 && nx < n && ny >= 0 && ny < n && dist[nx][ny] == -1) {
                    dist[nx][ny] = dist[x][y] + 1;
                    q.push({nx, ny});
                }
            }

            if (teleport[x][y] != -1) {
                int tx = teleport[x][y] / n;
                int ty = teleport[x][y] % n;
                if (dist[tx][ty] == -1) {
                    dist[tx][ty] = dist[x][y] + 1;
                    q.push({tx, ty});
                }
            }
        }

        return dist[n-1][n-1];
    }

    int minTimeToReachEnd(int n, vector<vector<int>>& grid, vector<vector<int>>& teleport) {
        return bfs(n, grid, teleport);
    }
};