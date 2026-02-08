#include <vector>
#include <queue>
#include <algorithm> // For std::max
#include <climits>   // For INT_MAX

class Solution {
public:
    // Helper function to check if a path exists with a minimum safeness factor k
    bool can_reach(int k, int n, const std::vector<std::vector<int>>& dist) {
        // If the starting or ending cell has a safeness factor less than k, no path is possible
        if (dist[0][0] < k || dist[n - 1][n - 1] < k) {
            return false;
        }

        std::queue<std::pair<int, int>> q_path;
        std::vector<std::vector<bool>> visited_path(n, std::vector<bool>(n, false));

        q_path.push({0, 0});
        visited_path[0][0] = true;

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        while (!q_path.empty()) {
            std::pair<int, int> curr = q_path.front();
            q_path.pop();
            int r = curr.first;
            int c = curr.second;

            // Reached the destination
            if (r == n - 1 && c == n - 1) {
                return true;
            }

            // Explore neighbors
            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                // Check bounds, if not visited, and if safeness factor is sufficient
                if (nr >= 0 && nr < n && nc >= 0 && nc < n && !visited_path[nr][nc] && dist[nr][nc] >= k) {
                    visited_path[nr][nc] = true;
                    q_path.push({nr, nc});
                }
            }
        }
        // Destination not reachable with the given minimum safeness factor k
        return false;
    }

    int maximumSafenessFactor(std::vector<std::vector<int>>& grid) {
        int n = grid.size();

        // Step 1: Calculate Manhattan distance to the nearest thief for all cells
        // Initialize distances to INT_MAX (unvisited/infinite distance)
        std::vector<std::vector<int>> dist(n, std::vector<int>(n, INT_MAX));
        std::queue<std::pair<int, int>> q_bfs_thieves;

        // Add all thief cells to the queue and set their distance to 0
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) { // Thief present
                    q_bfs_thieves.push({i, j});
                    dist[i][j] = 0;
                }
            }
        }

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};
        int max_safeness_val = 0; // To track the maximum possible safeness factor found

        // Multi-source BFS to fill the dist array
        while (!q_bfs_thieves.empty()) {
            std::pair<int, int> curr = q_bfs_thieves.front();
            q_bfs_thieves.pop();
            int r = curr.first;
            int c = curr.second;

            max_safeness_val = std::max(max_safeness_val, dist[r][c]);

            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                // If neighbor is within bounds and unvisited (distance is INT_MAX)
                if (nr >= 0 && nr < n && nc >= 0 && nc < n && dist[nr][nc] == INT_MAX) {
                    dist[nr][nc] = dist[r][c] + 1;
                    q_bfs_thieves.push({nr, nc});
                }
            }
        }

        // Step 2: Binary search on the answer (the maximum minimum safeness factor)
        int low = 0;
        int high = max_safeness_val; // The maximum possible safeness factor is the max value in dist array
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (can_reach(mid, n, dist)) {
                ans = mid;         // It's possible to achieve 'mid' safeness, try for higher
                low = mid + 1;
            } else {
                high = mid - 1;    // 'mid' safeness is not possible, need to try lower
            }
        }

        return ans;
    }
};