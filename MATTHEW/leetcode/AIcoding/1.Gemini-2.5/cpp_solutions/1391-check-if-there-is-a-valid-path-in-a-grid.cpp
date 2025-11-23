#include <vector>
#include <queue>
#include <utility> // For std::pair

class Solution {
public:
    bool hasValidPath(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        // Define possible moves (dr, dc) for each street type.
        // For example, street 1 connects left (0,-1) and right (0,1).
        // The index corresponds to the street type (1-6).
        std::vector<std::vector<std::pair<int, int>>> moves(7);
        moves[1] = {{0, -1}, {0, 1}}; // Street 1: Left, Right
        moves[2] = {{-1, 0}, {1, 0}}; // Street 2: Up, Down
        moves[3] = {{0, -1}, {1, 0}}; // Street 3: Left, Down
        moves[4] = {{0, 1}, {1, 0}};  // Street 4: Right, Down
        moves[5] = {{0, -1}, {-1, 0}}; // Street 5: Left, Up
        moves[6] = {{0, 1}, {-1, 0}};  // Street 6: Right, Up

        std::vector<std::vector<bool>> visited(m, std::vector<bool>(n, false));
        std::queue<std::pair<int, int>> q;

        // Start BFS from (0,0)
        q.push({0, 0});
        visited[0][0] = true;

        while (!q.empty()) {
            std::pair<int, int> curr = q.front();
            q.pop();
            int r = curr.first;
            int c = curr.second;

            // If we reached the target cell (m-1, n-1), a valid path exists
            if (r == m - 1 && c == n - 1) {
                return true;
            }

            int current_street_type = grid[r][c];

            // Explore all possible directions from the current street
            for (const auto& move : moves[current_street_type]) {
                int dr = move.first;
                int dc = move.second;

                int next_r = r + dr;
                int next_c = c + dc;

                // Check boundary conditions and if the cell has already been visited
                if (next_r < 0 || next_r >= m || next_c < 0 || next_c >= n || visited[next_r][next_c]) {
                    continue;
                }

                int next_street_type = grid[next_r][next_c];

                // Crucial check: Verify if the next street allows an entry from the current street.
                // If we moved from (r,c) to (next_r, next_c) using (dr, dc),
                // then (next_r, next_c) must have an opening in the opposite direction (-dr, -dc).
                bool can_connect_back = false;
                for (const auto& next_move : moves[next_street_type]) {
                    if (next_move.first == -dr && next_move.second == -dc) {
                        can_connect_back = true;
                        break;
                    }
                }

                if (can_connect_back) {
                    visited[next_r][next_c] = true;
                    q.push({next_r, next_c});
                }
            }
        }

        // If the queue becomes empty and the target was not reached, no valid path exists
        return false;
    }
};