#include <vector>
#include <queue>
#include <limits>
#include <utility> // For std::pair
#include <algorithm> // For std::max

class Solution {
public:
    int minimumTime(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        // Special case: If target is the starting cell itself
        if (m == 1 && n == 1) {
            return 0;
        }

        // Specific rule from problem description:
        // "If grid[0][1] and grid[1][0] are both strictly greater than 1,
        // it is impossible to move from (0,0) at time 0."
        // This check is only relevant if both neighbors (0,1) and (1,0) exist.
        if (m > 1 && n > 1) {
            if (grid[0][1] > 1 && grid[1][0] > 1) {
                return -1;
            }
        }
        // If m=1 or n=1, one of grid[0][1] or grid[1][0] would be out of bounds
        // or not exist, thus the condition "both strictly greater than 1" cannot be met.
        // So, the above check implicitly handles cases where m=1 or n=1 correctly.

        // dist[r][c] stores the minimum time to visit cell (r, c).
        // Initialize with a very large value (infinity).
        std::vector<std::vector<int>> dist(m, std::vector<int>(n, std::numeric_limits<int>::max()));

        // Priority queue for Dijkstra's algorithm.
        // Stores {time, {row, col}}.
        // Uses std::greater to make it a min-heap based on time.
        std::priority_queue<std::pair<int, std::pair<int, int>>,
                            std::vector<std::pair<int, std::pair<int, int>>>,
                            std::greater<std::pair<int, std::pair<int, int>>>> pq;

        // Start at (0,0) at time 0. The constraint grid[0][0] does not apply to the start.
        dist[0][0] = 0;
        pq.push({0, {0, 0}});

        // Directions for moving to adjacent cells (up, down, left, right)
        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        while (!pq.empty()) {
            auto [currentTime, pos] = pq.top();
            pq.pop();
            int r = pos.first;
            int c = pos.second;

            // If we have already found a shorter path to this cell, skip.
            if (currentTime > dist[r][c]) {
                continue;
            }

            // If we reached the target cell (m-1, n-1), return the current time.
            if (r == m - 1 && c == n - 1) {
                return currentTime;
            }

            // Explore all four possible neighbors
            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                // Check if the neighbor is within grid boundaries
                if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                    // Time to travel from (r,c) to (nr,nc) is 1 unit.
                    // So, we arrive at (nr,nc) at currentTime + 1.
                    // However, we can only visit (nr,nc) if the time is at least grid[nr][nc].
                    // Thus, the actual time we visit (nr,nc) is max(currentTime + 1, grid[nr][nc]).
                    int nextVisitTime = std::max(currentTime + 1, grid[nr][nc]);

                    // If this path offers a shorter time to visit (nr,nc), update and push to PQ.
                    if (nextVisitTime < dist[nr][nc]) {
                        dist[nr][nc] = nextVisitTime;
                        pq.push({nextVisitTime, {nr, nc}});
                    }
                }
            }
        }

        // If the target cell (m-1, n-1) was never reached (its distance remains INT_MAX),
        // it means it's impossible to visit.
        return -1;
    }
};