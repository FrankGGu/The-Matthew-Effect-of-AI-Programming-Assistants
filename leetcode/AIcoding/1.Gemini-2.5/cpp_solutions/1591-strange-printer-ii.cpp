#include <vector>
#include <queue>
#include <set>
#include <algorithm>

class Solution {
public:
    bool isPrintable(std::vector<std::vector<int>>& targetGrid) {
        int m = targetGrid.size();
        int n = targetGrid[0].size();

        const int MAX_COLOR = 61; // Colors are 1 to 60, use 61 for 1-indexed arrays

        std::vector<int> min_r(MAX_COLOR, m);
        std::vector<int> max_r(MAX_COLOR, -1);
        std::vector<int> min_c(MAX_COLOR, n);
        std::vector<int> max_c(MAX_COLOR, -1);

        std::vector<bool> present_colors(MAX_COLOR, false);
        int num_present_colors = 0;

        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                int color = targetGrid[r][c];
                if (!present_colors[color]) {
                    present_colors[color] = true;
                    num_present_colors++;
                }
                min_r[color] = std::min(min_r[color], r);
                max_r[color] = std::max(max_r[color], r);
                min_c[color] = std::min(min_c[color], c);
                max_c[color] = std::max(max_c[color], c);
            }
        }

        std::vector<std::set<int>> adj(MAX_COLOR);
        std::vector<int> indegree(MAX_COLOR, 0);

        for (int color_u = 1; color_u < MAX_COLOR; ++color_u) {
            if (!present_colors[color_u]) {
                continue;
            }

            for (int r = min_r[color_u]; r <= max_r[color_u]; ++r) {
                for (int c = min_c[color_u]; c <= max_c[color_u]; ++c) {
                    int color_v = targetGrid[r][c];
                    if (color_v != color_u) {
                        if (adj[color_u].find(color_v) == adj[color_u].end()) {
                            adj[color_u].insert(color_v);
                            indegree[color_v]++;
                        }
                    }
                }
            }
        }

        std::queue<int> q;
        std::vector<int> topo_order;

        for (int color = 1; color < MAX_COLOR; ++color) {
            if (present_colors[color] && indegree[color] == 0) {
                q.push(color);
            }
        }

        while (!q.empty()) {
            int u = q.front();
            q.pop();
            topo_order.push_back(u);

            for (int v : adj[u]) {
                indegree[v]--;
                if (indegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        if (topo_order.size() != num_present_colors) {
            return false;
        }

        std::vector<std::vector<int>> current_grid = targetGrid;

        for (int i = topo_order.size() - 1; i >= 0; --i) {
            int color_to_unprint = topo_order[i];

            for (int r = min_r[color_to_unprint]; r <= max_r[color_to_unprint]; ++r) {
                for (int c = min_c[color_to_unprint]; c <= max_c[color_to_unprint]; ++c) {
                    if (current_grid[r][c] != color_to_unprint && current_grid[r][c] != 0) {
                        return false;
                    }
                }
            }

            for (int r = min_r[color_to_unprint]; r <= max_r[color_to_unprint]; ++r) {
                for (int c = min_c[color_to_unprint]; c <= max_c[color_to_unprint]; ++c) {
                    current_grid[r][c] = 0;
                }
            }
        }

        return true;
    }
};