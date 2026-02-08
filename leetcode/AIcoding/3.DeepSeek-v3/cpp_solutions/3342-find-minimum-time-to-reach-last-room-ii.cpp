#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int findMinimumTime(vector<vector<int>>& rooms) {
        int m = rooms.size();
        if (m == 0) return 0;
        int n = rooms[0].size();
        if (n == 0) return 0;

        vector<vector<int>> dist(m, vector<int>(n, INT_MAX));
        dist[0][0] = 0;

        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<pair<int, pair<int, int>>>> pq;
        pq.push({0, {0, 0}});

        vector<pair<int, int>> dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        while (!pq.empty()) {
            auto curr = pq.top();
            pq.pop();
            int currentDist = curr.first;
            int x = curr.second.first;
            int y = curr.second.second;

            if (x == m - 1 && y == n - 1) {
                return currentDist;
            }

            if (currentDist > dist[x][y]) {
                continue;
            }

            for (auto dir : dirs) {
                int nx = x + dir.first;
                int ny = y + dir.second;

                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    int newDist = max(currentDist, abs(rooms[nx][ny] - rooms[x][y]));
                    if (newDist < dist[nx][ny]) {
                        dist[nx][ny] = newDist;
                        pq.push({newDist, {nx, ny}});
                    }
                }
            }
        }

        return dist[m - 1][n - 1];
    }
};