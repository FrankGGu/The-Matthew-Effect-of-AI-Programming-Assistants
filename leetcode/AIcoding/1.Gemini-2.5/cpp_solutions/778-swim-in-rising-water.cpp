#include <vector>
#include <queue>
#include <tuple>
#include <algorithm>
#include <limits>

class Solution {
public:
    int swimInRisingWater(std::vector<std::vector<int>>& grid) {
        int N = grid.size();

        // min_max_elevation[r][c] stores the minimum 't' (maximum elevation encountered
        // on a path from (0,0) to (r,c)) required to reach cell (r,c).
        std::vector<std::vector<int>> min_max_elevation(N, std::vector<int>(N, std::numeric_limits<int>::max()));

        // Priority queue stores tuples of (current_max_elevation, row, col).
        // It's a min-priority queue, ordered by current_max_elevation.
        std::priority_queue<std::tuple<int, int, int>,
                            std::vector<std::tuple<int, int, int>>,
                            std::greater<std::tuple<int, int, int>>> pq;

        // Directions for moving (up, down, left, right)
        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        // Start at (0, 0). The initial max elevation is grid[0][0].
        min_max_elevation[0][0] = grid[0][0];
        pq.push({grid[0][0], 0, 0});

        while (!pq.empty()) {
            auto [current_max_elevation, r, c] = pq.top();
            pq.pop();

            // If we have already found a path to (r, c) with a smaller or equal
            // maximum elevation, then this path is not optimal, so skip.
            if (current_max_elevation > min_max_elevation[r][c]) {
                continue;
            }

            // If we reached the destination (N-1, N-1), this is the minimum
            // maximum elevation required, because we are using a min-priority queue.
            if (r == N - 1 && c == N - 1) {
                return current_max_elevation;
            }

            // Explore neighbors
            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                // Check if the neighbor is within grid boundaries
                if (nr >= 0 && nr < N && nc >= 0 && nc < N) {
                    // The 'time' (maximum elevation) to reach the neighbor (nr, nc)
                    // through the current path is the maximum of the current path's
                    // max_elevation and the elevation of the neighbor cell itself.
                    int new_max_elevation = std::max(current_max_elevation, grid[nr][nc]);

                    // If we found a better path (one with a smaller new_max_elevation)
                    // to (nr, nc), update its min_max_elevation and push it to the priority queue.
                    if (new_max_elevation < min_max_elevation[nr][nc]) {
                        min_max_elevation[nr][nc] = new_max_elevation;
                        pq.push({new_max_elevation, nr, nc});
                    }
                }
            }
        }

        // This line should ideally not be reached if a path always exists,
        // as per problem constraints (grid is always valid and path exists).
        return -1; 
    }
};