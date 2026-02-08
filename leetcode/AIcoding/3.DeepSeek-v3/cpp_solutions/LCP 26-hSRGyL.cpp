#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int minSailCost(vector<vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return 0;
        int n = grid[0].size();
        if (n == 0) return 0;

        vector<vector<int>> cost(m, vector<int>(n, INT_MAX));
        vector<vector<bool>> visited(m, vector<bool>(n, false));
        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<pair<int, pair<int, int>>>> pq;

        if (grid[0][0] == 2) return -1;
        cost[0][0] = grid[0][0] == 1 ? 1 : 2;
        pq.push({cost[0][0], {0, 0}});

        int dirs[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        while (!pq.empty()) {
            auto curr = pq.top();
            pq.pop();
            int currCost = curr.first;
            int x = curr.second.first;
            int y = curr.second.second;

            if (visited[x][y]) continue;
            visited[x][y] = true;

            if (x == m - 1 && y == n - 1) {
                return currCost;
            }

            for (auto dir : dirs) {
                int nx = x + dir[0];
                int ny = y + dir[1];

                if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] != 2 && !visited[nx][ny]) {
                    int newCost = currCost + (grid[nx][ny] == 1 ? 1 : 2);
                    if (newCost < cost[nx][ny]) {
                        cost[nx][ny] = newCost;
                        pq.push({newCost, {nx, ny}});
                    }
                }
            }
        }

        return -1;
    }
};