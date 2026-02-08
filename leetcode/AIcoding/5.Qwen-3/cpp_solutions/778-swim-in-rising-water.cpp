#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int swimInWater(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<vector<bool>> visited(n, vector<bool>(n, false));
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
        pq.push({grid[0][0], 0});
        visited[0][0] = true;
        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        int result = grid[0][0];

        while (!pq.empty()) {
            auto [time, pos] = pq.top();
            pq.pop();
            result = max(result, time);
            int x = pos / n;
            int y = pos % n;
            if (x == n - 1 && y == n - 1) {
                return result;
            }
            for (auto& dir : dirs) {
                int nx = x + dir[0];
                int ny = y + dir[1];
                if (nx >= 0 && nx < n && ny >= 0 && ny < n && !visited[nx][ny]) {
                    visited[nx][ny] = true;
                    pq.push({grid[nx][ny], nx * n + ny});
                }
            }
        }
        return result;
    }
};