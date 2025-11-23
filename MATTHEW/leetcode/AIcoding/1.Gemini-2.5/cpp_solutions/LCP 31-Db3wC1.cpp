#include <vector>
#include <queue>
#include <tuple>
#include <limits>

class Solution {
public:
    int solve(std::vector<std::vector<int>>& grid, int sr, int sc, int tr, int tc) {
        int R = grid.size();
        if (R == 0) return -1;
        int C = grid[0].size();
        if (C == 0) return -1;

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        const int INF = std::numeric_limits<int>::max();
        std::vector<std::vector<int>> obstacle_time(R, std::vector<int>(C, INF));
        std::queue<std::tuple<int, int, int>> q_precompute;

        for (int r = 0; r < R; ++r) {
            for (int c = 0; c < C; ++c) {
                if (grid[r][c] == 1) {
                    obstacle_time[r][c] = 0;
                    q_precompute.push({r, c, 0});
                }
            }
        }

        while (!q_precompute.empty()) {
            auto [r, c, t] = q_precompute.front();
            q_precompute.pop();

            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < R && nc >= 0 && nc < C) {
                    if (obstacle_time[nr][nc] == INF) {
                        obstacle_time[nr][nc] = t + 1;
                        q_precompute.push({nr, nc, t + 1});
                    }
                }
            }
        }

        std::queue<std::tuple<int, int, int>> q_pathfind;
        std::vector<std::vector<int>> visited(R, std::vector<int>(C, INF));

        if (0 >= obstacle_time[sr][sc]) {
             return -1;
        }

        q_pathfind.push({sr, sc, 0});
        visited[sr][sc] = 0;

        while (!q_pathfind.empty()) {
            auto [r, c, t] = q_pathfind.front();
            q_pathfind.pop();

            if (r == tr && c == tc) {
                return t;
            }

            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];
                int next_time = t + 1;

                if (nr >= 0 && nr < R && nc >= 0 && nc < C) {
                    if (next_time < obstacle_time[nr][nc] && visited[nr][nc] == INF) {
                        visited[nr][nc] = next_time;
                        q_pathfind.push({nr, nc, next_time});
                    }
                }
            }
        }

        return -1;
    }
};