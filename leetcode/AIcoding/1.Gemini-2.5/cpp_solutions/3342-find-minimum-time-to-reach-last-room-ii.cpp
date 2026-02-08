#include <vector>
#include <queue>
#include <tuple>
#include <limits>
#include <algorithm>

class Solution {
public:
    int findMinimumTime(std::vector<std::vector<int>>& rooms) {
        int m = rooms.size();
        int n = rooms[0].size();

        std::vector<std::vector<long long>> dist(m, std::vector<long long>(n, std::numeric_limits<long long>::max()));

        using State = std::tuple<long long, int, int>;
        std::priority_queue<State, std::vector<State>, std::greater<State>> pq;

        dist[0][0] = rooms[0][0];
        pq.push({(long long)rooms[0][0], 0, 0});

        int dirs[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        while (!pq.empty()) {
            auto [time, r, c] = pq.top();
            pq.pop();

            if (time > dist[r][c]) {
                continue;
            }

            if (r == m - 1 && c == n - 1) {
                return time;
            }

            for (auto& dir : dirs) {
                int nr = r + dir[0];
                int nc = c + dir[1];

                if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                    long long new_time = std::max(time + 1, (long long)rooms[nr][nc]);
                    if (new_time < dist[nr][nc]) {
                        dist[nr][nc] = new_time;
                        pq.push({new_time, nr, nc});
                    }
                }
            }
        }

        return -1;
    }
};