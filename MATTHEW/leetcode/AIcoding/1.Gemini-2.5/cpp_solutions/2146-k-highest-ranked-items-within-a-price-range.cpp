#include <vector>
#include <queue>
#include <algorithm>
#include <tuple>

class Solution {
public:
    std::vector<std::vector<int>> kHighestRankedItems(
        std::vector<std::vector<int>>& grid,
        std::vector<int>& pricing,
        std::vector<int>& start,
        int k) {

        int m = grid.size();
        int n = grid[0].size();
        int low = pricing[0];
        int high = pricing[1];
        int start_r = start[0];
        int start_c = start[1];

        std::vector<std::tuple<int, int, int, int>> candidates;
        std::queue<std::pair<int, int>> q;
        std::vector<std::vector<bool>> visited(m, std::vector<bool>(n, false));

        q.push({start_r, start_c});
        visited[start_r][start_c] = true;
        int dist = 0;

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        while (!q.empty()) {
            int level_size = q.size();
            for (int i = 0; i < level_size; ++i) {
                auto [r, c] = q.front();
                q.pop();

                int price = grid[r][c];
                if (price > 1 && price >= low && price <= high) {
                    candidates.emplace_back(dist, price, r, c);
                }

                for (int j = 0; j < 4; ++j) {
                    int nr = r + dr[j];
                    int nc = c + dc[j];

                    if (nr >= 0 && nr < m && nc >= 0 && nc < n &&
                        !visited[nr][nc] && grid[nr][nc] != 0) {
                        visited[nr][nc] = true;
                        q.push({nr, nc});
                    }
                }
            }
            dist++;
        }

        std::sort(candidates.begin(), candidates.end());

        std::vector<std::vector<int>> result;
        for (int i = 0; i < std::min((int)candidates.size(), k); ++i) {
            const auto& [d, p, r, c] = candidates[i];
            result.push_back({r, c});
        }

        return result;
    }
};