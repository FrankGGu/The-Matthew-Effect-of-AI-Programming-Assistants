#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int maxDistance(vector<vector<int>>& grid) {
        int n = grid.size();
        queue<pair<int, int>> q;
        vector<vector<int>> dist(n, vector<int>(n, INT_MAX));

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    dist[i][j] = 0;
                    q.push({i, j});
                }
            }
        }

        if (q.empty() || q.size() == n * n) {
            return -1;
        }

        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        int maxDist = -1;

        while (!q.empty()) {
            auto curr = q.front();
            q.pop();
            int x = curr.first;
            int y = curr.second;

            for (auto& dir : dirs) {
                int nx = x + dir[0];
                int ny = y + dir[1];

                if (nx >= 0 && nx < n && ny >= 0 && ny < n && dist[nx][ny] > dist[x][y] + 1) {
                    dist[nx][ny] = dist[x][y] + 1;
                    maxDist = max(maxDist, dist[nx][ny]);
                    q.push({nx, ny});
                }
            }
        }

        return maxDist;
    }
};