#include <vector>
#include <string>
#include <queue>
#include <tuple>

class Solution {
public:
    int nearestExit(std::vector<std::string>& maze, std::vector<int>& entrance) {
        int m = maze.size();
        int n = maze[0].size();

        std::queue<std::tuple<int, int, int>> q; // (row, col, steps)
        std::vector<std::vector<bool>> visited(m, std::vector<bool>(n, false));

        int start_r = entrance[0];
        int start_c = entrance[1];

        q.push({start_r, start_c, 0});
        visited[start_r][start_c] = true;

        int dr[] = {-1, 1, 0, 0}; // Up, Down
        int dc[] = {0, 0, -1, 1}; // Left, Right

        while (!q.empty()) {
            auto [r, c, steps] = q.front();
            q.pop();

            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                // Check bounds
                if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                    // Check if it's an empty cell and not visited
                    if (maze[nr][nc] == '.' && !visited[nr][nc]) {
                        // Check if it's an exit (on border and not the entrance)
                        if ((nr == 0 || nr == m - 1 || nc == 0 || nc == n - 1)) {
                            return steps + 1;
                        }

                        visited[nr][nc] = true;
                        q.push({nr, nc, steps + 1});
                    }
                }
            }
        }

        return -1; // No exit found
    }
};