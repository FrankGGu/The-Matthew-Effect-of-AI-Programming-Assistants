#include <vector>
#include <queue>
#include <unordered_map>
#include <unordered_set>
#include <utility>

class Solution {
public:
    int gridTeleportationTraversal(std::vector<std::vector<int>>& grid, int startR, int startC, int targetR, int targetC) {
        int m = grid.size();
        if (m == 0) return -1;
        int n = grid[0].size();
        if (n == 0) return -1;

        if (startR == targetR && startC == targetC) {
            return 0;
        }

        std::unordered_map<int, std::vector<std::pair<int, int>>> teleports;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] > 1) {
                    teleports[grid[i][j]].push_back({i, j});
                }
            }
        }

        std::queue<std::pair<int, int>> q;
        std::vector<std::vector<int>> dist(m, std::vector<int>(n, -1));
        std::unordered_set<int> visited_teleports;

        q.push({startR, startC});
        dist[startR][startC] = 0;

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        while (!q.empty()) {
            auto [r, c] = q.front();
            q.pop();

            int current_dist = dist[r][c];

            if (r == targetR && c == targetC) {
                return current_dist;
            }

            // 1. Move to adjacent cells
            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] != 1 && dist[nr][nc] == -1) {
                    dist[nr][nc] = current_dist + 1;
                    q.push({nr, nc});
                }
            }

            // 2. Use teleportation
            int val = grid[r][c];
            if (val > 1 && visited_teleports.find(val) == visited_teleports.end()) {
                visited_teleports.insert(val);
                if (teleports.count(val)) {
                    for (const auto& [tr, tc] : teleports[val]) {
                        if (dist[tr][tc] == -1) {
                            dist[tr][tc] = current_dist + 1;
                            q.push({tr, tc});
                        }
                    }
                }
            }
        }

        return -1;
    }
};