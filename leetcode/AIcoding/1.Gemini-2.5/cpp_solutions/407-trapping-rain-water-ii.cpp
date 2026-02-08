#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int trapRainWater(vector<vector<int>>& heightMap) {
        if (heightMap.empty() || heightMap[0].empty()) return 0;
        int m = heightMap.size(), n = heightMap[0].size();
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        vector<vector<bool>> visited(m, vector<bool>(n, false));

        for (int i = 0; i < m; ++i) {
            visited[i][0] = visited[i][n - 1] = true;
            pq.push({heightMap[i][0], i * n + 0});
            pq.push({heightMap[i][n - 1], i * n + (n - 1)});
        }
        for (int j = 1; j < n - 1; ++j) {
            visited[0][j] = visited[m - 1][j] = true;
            pq.push({heightMap[0][j], 0 * n + j});
            pq.push({heightMap[m - 1][j], (m - 1) * n + j});
        }

        int water = 0;
        vector<int> dx = {0, 0, 1, -1};
        vector<int> dy = {1, -1, 0, 0};

        while (!pq.empty()) {
            auto curr = pq.top();
            pq.pop();
            int height = curr.first;
            int x = curr.second / n;
            int y = curr.second % n;

            for (int i = 0; i < 4; ++i) {
                int nx = x + dx[i];
                int ny = y + dy[i];

                if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny]) {
                    visited[nx][ny] = true;
                    water += max(0, height - heightMap[nx][ny]);
                    pq.push({max(heightMap[nx][ny], height), nx * n + ny});
                }
            }
        }

        return water;
    }
};