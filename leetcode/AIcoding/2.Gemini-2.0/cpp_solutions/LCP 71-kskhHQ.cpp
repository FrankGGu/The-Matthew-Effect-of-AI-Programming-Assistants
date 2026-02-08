#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int trapRainWater(vector<vector<int>>& heightMap) {
        if (heightMap.empty() || heightMap[0].empty()) return 0;

        int m = heightMap.size();
        int n = heightMap[0].size();

        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<pair<int, pair<int, int>>>> pq;
        vector<vector<bool>> visited(m, vector<bool>(n, false));

        for (int i = 0; i < m; ++i) {
            pq.push({heightMap[i][0], {i, 0}});
            visited[i][0] = true;
            pq.push({heightMap[i][n - 1], {i, n - 1}});
            visited[i][n - 1] = true;
        }

        for (int j = 1; j < n - 1; ++j) {
            pq.push({heightMap[0][j], {0, j}});
            visited[0][j] = true;
            pq.push({heightMap[m - 1][j], {m - 1, j}});
            visited[m - 1][j] = true;
        }

        int water = 0;
        int dx[] = {0, 0, 1, -1};
        int dy[] = {1, -1, 0, 0};

        while (!pq.empty()) {
            int height = pq.top().first;
            int x = pq.top().second.first;
            int y = pq.top().second.second;
            pq.pop();

            for (int i = 0; i < 4; ++i) {
                int nx = x + dx[i];
                int ny = y + dy[i];

                if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny]) {
                    visited[nx][ny] = true;
                    if (height > heightMap[nx][ny]) {
                        water += height - heightMap[nx][ny];
                        pq.push({height, {nx, ny}});
                    } else {
                        pq.push({heightMap[nx][ny], {nx, ny}});
                    }
                }
            }
        }

        return water;
    }
};