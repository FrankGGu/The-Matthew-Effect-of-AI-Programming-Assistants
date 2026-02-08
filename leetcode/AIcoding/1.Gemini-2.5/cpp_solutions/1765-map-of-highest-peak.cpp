#include <vector>
#include <queue>
#include <utility> // For std::pair

class Solution {
public:
    std::vector<std::vector<int>> highestPeak(std::vector<std::vector<int>>& isWater) {
        int m = isWater.size();
        int n = isWater[0].size();

        std::vector<std::vector<int>> heights(m, std::vector<int>(n, -1));
        std::queue<std::pair<int, int>> q;

        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                if (isWater[r][c] == 1) {
                    heights[r][c] = 0;
                    q.push({r, c});
                }
            }
        }

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        while (!q.empty()) {
            std::pair<int, int> curr = q.front();
            q.pop();
            int r = curr.first;
            int c = curr.second;

            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < m && nc >= 0 && nc < n && heights[nr][nc] == -1) {
                    heights[nr][nc] = heights[r][c] + 1;
                    q.push({nr, nc});
                }
            }
        }

        return heights;
    }
};