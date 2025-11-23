#include <vector>
#include <queue>
#include <tuple>

using namespace std;

class Solution {
public:
    int minimumTime(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<int>> time(m, vector<int>(n, INT_MAX));
        priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<tuple<int, int, int>>> pq;

        pq.emplace(0, 0, 0);
        time[0][0] = 0;

        vector<int> directions = {0, 1, 0, -1, 1, 0, -1, 0};

        while (!pq.empty()) {
            auto [t, x, y] = pq.top();
            pq.pop();

            if (x == m - 1 && y == n - 1) return t;

            for (int i = 0; i < 4; ++i) {
                int nx = x + directions[i];
                int ny = y + directions[i + 4];
                if (nx < 0 || nx >= m || ny < 0 || ny >= n) continue;
                int waitTime = (t % 2 == 0) ? 0 : (2 - (t % 2));
                int newTime = t + waitTime + grid[nx][ny];
                if (newTime < time[nx][ny]) {
                    time[nx][ny] = newTime;
                    pq.emplace(newTime, nx, ny);
                }
            }
        }

        return -1;
    }
};