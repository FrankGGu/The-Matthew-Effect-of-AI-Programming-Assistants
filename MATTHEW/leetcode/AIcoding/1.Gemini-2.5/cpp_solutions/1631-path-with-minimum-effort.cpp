#include <vector>
#include <queue>
#include <tuple>
#include <cmath>
#include <limits>
#include <functional>

class Solution {
public:
    int minimumEffortPath(std::vector<std::vector<int>>& heights) {
        int rows = heights.size();
        int cols = heights[0].size();

        std::vector<std::vector<int>> dist(rows, std::vector<int>(cols, std::numeric_limits<int>::max()));

        std::priority_queue<std::tuple<int, int, int>, 
                            std::vector<std::tuple<int, int, int>>, 
                            std::greater<std::tuple<int, int, int>>> pq;

        dist[0][0] = 0;
        pq.push({0, 0, 0});

        int dr[] = {-1, 1, 0, 0}; 
        int dc[] = {0, 0, -1, 1}; 

        while (!pq.empty()) {
            auto [current_effort, r, c] = pq.top();
            pq.pop();

            if (r == rows - 1 && c == cols - 1) {
                return current_effort;
            }

            if (current_effort > dist[r][c]) {
                continue;
            }

            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < rows && nc >= 0 && nc < cols) {
                    int effort_to_neighbor = std::abs(heights[r][c] - heights[nr][nc]);
                    int new_max_effort = std::max(current_effort, effort_to_neighbor);

                    if (new_max_effort < dist[nr][nc]) {
                        dist[nr][nc] = new_max_effort;
                        pq.push({new_max_effort, nr, nc});
                    }
                }
            }
        }

        return dist[rows - 1][cols - 1]; 
    }
};