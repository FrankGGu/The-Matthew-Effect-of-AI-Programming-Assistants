#include <vector>
#include <string>
#include <queue>
#include <tuple>
#include <algorithm> // For std::max

class Solution {
public:
    int shortestPathAllKeys(std::vector<std::string>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        int start_r, start_c;
        int all_keys_target_mask = 0; // This will store the mask of all keys present in the grid

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == '@') {
                    start_r = i;
                    start_c = j;
                } else if (grid[i][j] >= 'a' && grid[i][j] <= 'f') {
                    all_keys_target_mask |= (1 << (grid[i][j] - 'a'));
                }
            }
        }

        // BFS state: (row, col, keys_mask, steps)
        std::queue<std::tuple<int, int, int, int>> q;

        // Visited states: (row, col, keys_mask)
        // Using a 3D vector for distance, initialized to -1 (unvisited)
        // Max 6 keys (a-f), so 2^6 = 64 possible masks
        std::vector<std::vector<std::vector<int>>> dist(m, std::vector<std::vector<int>>(n, std::vector<int>(1 << 6, -1)));

        q.push({start_r, start_c, 0, 0});
        dist[start_r][start_c][0] = 0;

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        while (!q.empty()) {
            auto [r, c, current_keys, steps] = q.front();
            q.pop();

            if (current_keys == all_keys_target_mask) {
                return steps;
            }

            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                    char cell = grid[nr][nc];

                    if (cell == '#') {
                        continue; // Wall
                    }

                    if (cell >= 'A' && cell <= 'F') { // Lock
                        // Check if we have the corresponding key
                        if (!((current_keys >> (cell - 'A')) & 1)) {
                            continue; // Don't have the key for this lock
                        }
                    }

                    int new_keys = current_keys;
                    if (cell >= 'a' && cell <= 'f') { // Key
                        new_keys |= (1 << (cell - 'a'));
                    }

                    // If this state (nr, nc, new_keys) has not been visited before
                    if (dist[nr][nc][new_keys] == -1) {
                        dist[nr][nc][new_keys] = steps + 1;
                        q.push({nr, nc, new_keys, steps + 1});
                    }
                }
            }
        }

        return -1; // Cannot collect all keys
    }
};