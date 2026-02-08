#include <vector>
#include <numeric> // For std::iota
#include <algorithm> // For std::max

class Solution {
private:
    class DSU {
    public:
        std::vector<int> parent;
        std::vector<int> sz; // size of component

        DSU(int n) {
            parent.resize(n);
            std::iota(parent.begin(), parent.end(), 0);
            sz.assign(n, 1);
        }

        int find(int i) {
            if (parent[i] == i)
                return i;
            return parent[i] = find(parent[i]);
        }

        void unite(int i, int j) {
            int root_i = find(i);
            int root_j = find(j);
            if (root_i != root_j) {
                parent[root_j] = root_i;
                sz[root_i] += sz[root_j];
            }
        }
    };

public:
    std::vector<int> hitBricks(std::vector<std::vector<int>>& grid, std::vector<std::vector<int>>& hits) {
        int m = grid.size();
        int n = grid[0].size();

        std::vector<std::vector<int>> temp_grid = grid;

        for (const auto& hit : hits) {
            temp_grid[hit[0]][hit[1]] = 0;
        }

        DSU dsu(m * n + 1); // m*n elements for cells + 1 for virtual ceiling node (index m*n)

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        // Initial DSU setup for the temp_grid (after all hits)
        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                if (temp_grid[r][c] == 1) {
                    int cell_idx = r * n + c;
                    if (r == 0) {
                        dsu.unite(cell_idx, m * n); // Connect to ceiling
                    }
                    for (int i = 0; i < 4; ++i) {
                        int nr = r + dr[i];
                        int nc = c + dc[i];
                        if (nr >= 0 && nr < m && nc >= 0 && nc < n && temp_grid[nr][nc] == 1) {
                            dsu.unite(cell_idx, nr * n + nc);
                        }
                    }
                }
            }
        }

        std::vector<int> ans(hits.size());
        for (int i = hits.size() - 1; i >= 0; --i) {
            int r = hits[i][0];
            int c = hits[i][1];
            int cell_idx = r * n + c;

            if (grid[r][c] == 0) { // If original cell was not a brick, no bricks fall
                ans[i] = 0;
                continue;
            }

            // Number of bricks connected to the ceiling BEFORE adding this brick back
            // dsu.sz[dsu.find(m*n)] includes the virtual ceiling node itself, so subtract 1
            int prev_ceiling_bricks = dsu.sz[dsu.find(m * n)] - 1;

            temp_grid[r][c] = 1; // Add the brick back

            // Connect this brick to its neighbors and ceiling
            if (r == 0) {
                dsu.unite(cell_idx, m * n);
            }
            for (int k = 0; k < 4; ++k) {
                int nr = r + dr[k];
                int nc = c + dc[k];
                if (nr >= 0 && nr < m && nc >= 0 && nc < n && temp_grid[nr][nc] == 1) {
                    dsu.unite(cell_idx, nr * n + nc);
                }
            }

            // Number of bricks connected to the ceiling AFTER adding this brick back
            int curr_ceiling_bricks = dsu.sz[dsu.find(m * n)] - 1;

            // The number of bricks that fall is the difference, minus 1 (for the brick itself that was just added back).
            // Use max(0, ...) to handle cases where the added brick doesn't connect to the ceiling
            // or if it was already connected through other paths (resulting in 0 or negative difference).
            ans[i] = std::max(0, curr_ceiling_bricks - prev_ceiling_bricks - 1);
        }

        return ans;
    }
};