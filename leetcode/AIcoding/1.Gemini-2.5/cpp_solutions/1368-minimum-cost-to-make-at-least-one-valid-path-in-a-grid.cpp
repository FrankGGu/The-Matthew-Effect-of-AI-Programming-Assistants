#include <vector>
#include <deque>
#include <tuple>
#include <limits>

class Solution {
public:
    int minCost(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        std::vector<std::vector<int>> dist(m, std::vector<int>(n, std::numeric_limits<int>::max()));
        std::deque<std::tuple<int, int, int>> dq; // {cost, row, col}

        // Directions: right, left, down, up
        int dr[] = {0, 0, 1, -1};
        int dc[] = {1, -1, 0, 0};

        dist[0][0] = 0;
        dq.push_front({0, 0, 0});

        while (!dq.empty()) {
            auto [cost, r, c] = dq.front();
            dq.pop_front();

            if (cost > dist[r][c]) {
                continue;
            }

            // If we reached the target, we can return early
            if (r == m - 1 && c == n - 1) {
                return cost;
            }

            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                    int new_cost = cost;
                    // grid[r][c] values are 1-indexed for directions
                    // 1: right (dr[0], dc[0])
                    // 2: left  (dr[1], dc[1])
                    // 3: down  (dr[2], dc[2])
                    // 4: up    (dr[3], dc[3])
                    if (grid[r][c] - 1 != i) { // If current direction is not preferred
                        new_cost += 1;
                    }

                    if (new_cost < dist[nr][nc]) {
                        dist[nr][nc] = new_cost;
                        if (grid[r][c] - 1 == i) { // 0-cost edge
                            dq.push_front({new_cost, nr, nc});
                        } else { // 1-cost edge
                            dq.push_back({new_cost, nr, nc});
                        }
                    }
                }
            }
        }

        return dist[m - 1][n - 1];
    }
};