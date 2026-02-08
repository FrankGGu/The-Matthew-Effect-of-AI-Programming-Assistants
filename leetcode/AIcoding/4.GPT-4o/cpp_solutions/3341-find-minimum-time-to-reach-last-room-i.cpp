#include <vector>
#include <queue>
#include <tuple>

using namespace std;

class Solution {
public:
    int minimumTime(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<int>> time(m, vector<int>(n, INT_MAX));
        time[0][0] = 0;
        priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<tuple<int, int, int>>> pq;
        pq.emplace(0, 0, 0);

        while (!pq.empty()) {
            auto [t, x, y] = pq.top();
            pq.pop();
            if (t > time[x][y]) continue;
            for (auto [dx, dy] : vector<pair<int, int>>{{1, 0}, {0, 1}, {-1, 0}, {0, -1}}) {
                int nx = x + dx, ny = y + dy;
                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    int waitTime = (t % 2 == grid[nx][ny] % 2) ? 1 : 0;
                    int newTime = t + 1 + waitTime;
                    if (newTime < time[nx][ny]) {
                        time[nx][ny] = newTime;
                        pq.emplace(newTime, nx, ny);
                    }
                }
            }
        }
        return time[m - 1][n - 1] == INT_MAX ? -1 : time[m - 1][n - 1];
    }
};