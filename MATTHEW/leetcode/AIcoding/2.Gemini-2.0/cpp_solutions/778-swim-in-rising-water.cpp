#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int swimInWater(vector<vector<int>>& grid) {
        int n = grid.size();
        priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<tuple<int, int, int>>> pq;
        vector<vector<bool>> visited(n, vector<bool>(n, false));

        pq.push({grid[0][0], 0, 0});
        visited[0][0] = true;

        int ans = 0;
        int dx[] = {0, 0, 1, -1};
        int dy[] = {1, -1, 0, 0};

        while (!pq.empty()) {
            auto [height, x, y] = pq.top();
            pq.pop();

            ans = max(ans, height);

            if (x == n - 1 && y == n - 1) {
                return ans;
            }

            for (int i = 0; i < 4; ++i) {
                int nx = x + dx[i];
                int ny = y + dy[i];

                if (nx >= 0 && nx < n && ny >= 0 && ny < n && !visited[nx][ny]) {
                    pq.push({grid[nx][ny], nx, ny});
                    visited[nx][ny] = true;
                }
            }
        }

        return -1;
    }
};