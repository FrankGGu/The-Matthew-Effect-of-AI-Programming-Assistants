#include <vector>
#include <string>
#include <queue>
#include <tuple>

class Solution {
public:
    int minSteps(std::vector<std::string>& maze) {
        int rows = maze.size();
        if (rows == 0) return -1;
        int cols = maze[0].size();
        if (cols == 0) return -1;

        int start_r = -1, start_c = -1;
        int end_r = -1, end_c = -1;

        for (int r = 0; r < rows; ++r) {
            for (int c = 0; c < cols; ++c) {
                if (maze[r][c] == 'S') {
                    start_r = r;
                    start_c = c;
                } else if (maze[r][c] == 'E') {
                    end_r = r;
                    end_c = c;
                }
            }
        }

        if (start_r == -1 || end_r == -1) {
            return -1;
        }

        std::queue<std::tuple<int, int, int>> q;
        q.push({start_r, start_c, 0});

        std::vector<std::vector<bool>> visited(rows, std::vector<bool>(cols, false));
        visited[start_r][start_c] = true;

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        while (!q.empty()) {
            auto [r, c, dist] = q.front();
            q.pop();

            if (r == end_r && c == end_c) {
                return dist;
            }

            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < rows && nc >= 0 && nc < cols &&
                    maze[nr][nc] != '#' && !visited[nr][nc]) {
                    visited[nr][nc] = true;
                    q.push({nr, nc, dist + 1});
                }
            }
        }

        return -1;
    }
};