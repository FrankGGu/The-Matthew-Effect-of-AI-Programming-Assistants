#include <vector>
#include <deque>
#include <limits>

class Solution {
public:
    int minimumObstacles(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        std::vector<std::vector<int>> dist(m, std::vector<int>(n, std::numeric_limits<int>::max()));
        std::deque<std::pair<int, int>> dq;

        dist[0][0] = grid[0][0];
        dq.push_front({0, 0});

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        while (!dq.empty()) {
            std::pair<int, int> curr = dq.front();
            dq.pop_front();
            int r = curr.first;
            int c = curr.second;

            if (r == m - 1 && c == n - 1) {
                return dist[r][c];
            }

            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                    int new_cost = dist[r][c] + grid[nr][nc];
                    if (new_cost < dist[nr][nc]) {
                        dist[nr][nc] = new_cost;
                        if (grid[nr][nc] == 0) {
                            dq.push_front({nr, nc});
                        } else {
                            dq.push_back({nr, nc});
                        }
                    }
                }
            }
        }

        return dist[m - 1][n - 1];
    }
};