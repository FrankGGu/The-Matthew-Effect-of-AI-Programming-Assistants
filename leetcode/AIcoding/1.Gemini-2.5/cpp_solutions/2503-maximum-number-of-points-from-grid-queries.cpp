#include <vector>
#include <queue>
#include <tuple>
#include <algorithm>

class Solution {
public:
    std::vector<int> maxPoints(std::vector<std::vector<int>>& grid, std::vector<int>& queries) {
        int n = grid.size();
        int m = grid[0].size();
        int num_queries = queries.size();

        std::vector<std::pair<int, int>> sorted_queries(num_queries);
        for (int i = 0; i < num_queries; ++i) {
            sorted_queries[i] = {queries[i], i};
        }
        std::sort(sorted_queries.begin(), sorted_queries.end());

        std::vector<int> ans(num_queries);
        std::vector<std::vector<bool>> visited(n, std::vector<bool>(m, false));

        // Priority queue stores {max_val_on_path, r, c}
        // min-heap based on max_val_on_path
        std::priority_queue<std::tuple<int, int, int>,
                            std::vector<std::tuple<int, int, int>>,
                            std::greater<std::tuple<int, int, int>>> pq;

        int processed_cells_count = 0;
        int query_ptr = 0;

        // Start Dijkstra from (0,0)
        pq.push({grid[0][0], 0, 0});
        visited[0][0] = true;

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        while (query_ptr < num_queries) {
            // Process cells from PQ as long as their max_val_on_path is strictly less than the current query value
            while (!pq.empty() && std::get<0>(pq.top()) < sorted_queries[query_ptr].first) {
                auto [max_val, r, c] = pq.top();
                pq.pop();

                processed_cells_count++;

                for (int i = 0; i < 4; ++i) {
                    int nr = r + dr[i];
                    int nc = c + dc[i];

                    if (nr >= 0 && nr < n && nc >= 0 && nc < m && !visited[nr][nc]) {
                        visited[nr][nc] = true;
                        pq.push({std::max(max_val, grid[nr][nc]), nr, nc});
                    }
                }
            }

            // Answer the current query with the number of cells processed so far
            ans[sorted_queries[query_ptr].second] = processed_cells_count;
            query_ptr++;
        }

        return ans;
    }
};