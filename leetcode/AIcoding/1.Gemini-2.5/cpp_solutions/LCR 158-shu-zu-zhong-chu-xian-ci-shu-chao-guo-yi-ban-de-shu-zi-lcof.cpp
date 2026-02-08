#include <vector>
#include <queue>
#include <tuple>
#include <algorithm> // For std::max

class Solution {
public:
    int trapRainWater(std::vector<std::vector<int>>& heightMap) {
        if (heightMap.empty() || heightMap[0].empty()) {
            return 0;
        }

        int m = heightMap.size();
        int n = heightMap[0].size();

        // Min-priority queue to store {height, row, col}
        // It stores cells that act as boundaries (walls) for water.
        std::priority_queue<std::tuple<int, int, int>, 
                            std::vector<std::tuple<int, int, int>>, 
                            std::greater<std::tuple<int, int, int>>> pq;

        std::vector<std::vector<bool>> visited(m, std::vector<bool>(n, false));

        // Add all border cells to the priority queue and mark them as visited.
        // These are the initial "walls" from which water cannot escape.
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == 0 || i == m - 1 || j == 0 || j == n - 1) {
                    pq.push({heightMap[i][j], i, j});
                    visited[i][j] = true;
                }
            }
        }

        int totalWater = 0;
        // Directions for neighbors (up, down, left, right)
        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        while (!pq.empty()) {
            // Get the cell with the minimum height from the priority queue.
            // This height represents the current "water level" or the lowest surrounding wall.
            auto [height, r, c] = pq.top(); 
            pq.pop();

            // Explore neighbors of the current cell
            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                // Check if the neighbor is within bounds and has not been visited yet
                if (nr >= 0 && nr < m && nc >= 0 && nc < n && !visited[nr][nc]) {
                    visited[nr][nc] = true;

                    // Calculate water trapped at this neighbor:
                    // If the current "water level" (height) is greater than the neighbor's height,
                    // then water can be trapped. The amount is (height - neighbor's height).
                    totalWater += std::max(0, height - heightMap[nr][nc]);

                    // Add the neighbor to the priority queue.
                    // Its effective height for future calculations (as a potential wall)
                    // is the maximum of the current "water level" (height) and its own height.
                    pq.push({std::max(height, heightMap[nr][nc]), nr, nc});
                }
            }
        }

        return totalWater;
    }
};