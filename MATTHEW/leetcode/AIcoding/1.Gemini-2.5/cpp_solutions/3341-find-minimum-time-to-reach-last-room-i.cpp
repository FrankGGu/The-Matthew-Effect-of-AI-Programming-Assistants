#include <vector>
#include <queue>
#include <tuple>
#include <climits>

class Solution {
public:
    int findMinimumTime(std::vector<std::vector<int>>& rooms) {
        int m = rooms.size();
        if (m == 0) {
            return 0;
        }
        int n = rooms[0].size();
        if (n == 0) {
            return 0;
        }

        std::vector<std::vector<int>> dist(m, std::vector<int>(n, INT_MAX));
        std::priority_queue<std::tuple<int, int, int>, 
                              std::vector<std::tuple<int, int, int>>, 
                              std::greater<std::tuple<int, int, int>>> pq;

        dist[0][0] = rooms[0][0];
        pq.push({rooms[0][0], 0, 0});

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        while (!pq.empty()) {
            auto [currentTime, r, c] = pq.top();
            pq.pop();

            if (currentTime > dist[r][c]) {
                continue;
            }

            if (r == m - 1 && c == n - 1) {
                return currentTime;
            }

            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                    int newTime = currentTime + rooms[nr][nc];
                    if (newTime < dist[nr][nc]) {
                        dist[nr][nc] = newTime;
                        pq.push({newTime, nr, nc});
                    }
                }
            }
        }

        return -1;
    }
};