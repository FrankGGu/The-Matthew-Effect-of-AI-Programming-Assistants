#include <vector>
#include <string>
#include <queue>
#include <map>
#include <tuple>
#include <cstring> // For memset

const int MAX_DIM = 50;
const int MAX_RELICT_COUNT_BITS = 10; // Max 9 relics means 2^9 masks. Use 10 for safety/generality.

int dist[MAX_DIM][MAX_DIM][1 << MAX_RELICT_COUNT_BITS];

class Solution {
public:
    int relicTransfer(std::vector<std::string>& grid) {
        int R = grid.size();
        if (R == 0) return -1;
        int C = grid[0].size();
        if (C == 0) return -1;

        int start_r = -1, start_c = -1;
        int end_r = -1, end_c = -1;
        std::vector<std::pair<int, int>> relic_positions;
        std::map<std::pair<int, int>, int> relic_to_idx; // Maps (r, c) of a relic to its bit index

        // Parse the grid to find 'S', 'E', and all relics.
        for (int r = 0; r < R; ++r) {
            for (int c = 0; c < C; ++c) {
                if (grid[r][c] == 'S') {
                    start_r = r;
                    start_c = c;
                } else if (grid[r][c] == 'E') {
                    end_r = r;
                    end_c = c;
                } else if (grid[r][c] >= '1' && grid[r][c] <= '9') {
                    // Assign a unique bit index to each relic.
                    relic_to_idx[{r, c}] = relic_positions.size();
                    relic_positions.push_back({r, c});
                }
            }
        }

        int num_relics = relic_positions.size();
        // The mask representing all relics collected.
        int all_relics_mask = (1 << num_relics) - 1;

        // Initialize the distance array with -1 to mark all states as unvisited.
        // `sizeof(dist)` covers the entire global array. This is efficient.
        memset(dist, -1, sizeof(dist));

        std::queue<std::tuple<int, int, int>> q; // Queue for BFS: {row, col, collected_relics_mask}

        // Determine the initial mask if 'S' cell itself contains a relic.
        int initial_mask = 0;
        if (grid[start_r][start_c] >= '1' && grid[start_r][start_c] <= '9') {
            initial_mask |= (1 << relic_to_idx[{start_r, start_c}]);
        }

        // Push the starting state to the queue.
        q.push({start_r, start_c, initial_mask});
        dist[start_r][start_c][initial_mask] = 0;

        // Directions for movement: up, down, left, right.
        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        // BFS loop
        while (!q.empty()) {
            auto [r, c, mask] = q.front();
            q.pop();
            int current_dist = dist[r][c][mask];

            // If we have reached the end point and collected all relics,
            // this is the shortest path due to BFS property.
            if (r == end_r && c == end_c && mask == all_relics_mask) {
                return current_dist;
            }

            // Explore neighbors
            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                // Check bounds
                if (nr < 0 || nr >= R || nc < 0 || nc >= C) continue;
                // Check for obstacles
                if (grid[nr][nc] == '#') continue;

                int next_mask = mask;
                // If the next cell contains a relic, update the mask.
                if (grid[nr][nc] >= '1' && grid[nr][nc] <= '9') {
                    int relic_idx = relic_to_idx[{nr, nc}];
                    next_mask |= (1 << relic_idx);
                }

                // If this new state (neighbor_r, neighbor_c, next_mask) has not been visited,
                // mark its distance and add it to the queue.
                if (dist[nr][nc][next_mask] == -1) {
                    dist[nr][nc][next_mask] = current_dist + 1;
                    q.push({nr, nc, next_mask});
                }
            }
        }

        // If the queue becomes empty and the target state was not reached, it's unreachable.
        return -1;
    }
};