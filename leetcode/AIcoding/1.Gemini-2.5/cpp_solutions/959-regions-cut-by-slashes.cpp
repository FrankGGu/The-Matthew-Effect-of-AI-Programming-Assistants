#include <vector>
#include <string>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::vector<int> parent;
    std::vector<int> sz;
    int count;

    int find(int i) {
        if (parent[i] == i)
            return i;
        return parent[i] = find(parent[i]);
    }

    void unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);
        if (root_i != root_j) {
            if (sz[root_i] < sz[root_j])
                std::swap(root_i, root_j);
            parent[root_j] = root_i;
            sz[root_i] += sz[root_j];
            count--;
        }
    }

    int regionsBySlashes(std::vector<std::string>& grid) {
        int N = grid.size();
        int total_parts = N * N * 4;
        parent.resize(total_parts);
        std::iota(parent.begin(), parent.end(), 0); // Initialize parent[i] = i
        sz.assign(total_parts, 1);
        count = total_parts;

        // Helper to get the index for a cell's part
        // (r, c, part) -> (r * N + c) * 4 + part
        // part: 0-top, 1-right, 2-bottom, 3-left
        auto get_idx = [&](int r, int c, int part) {
            return (r * N + c) * 4 + part;
        };

        for (int r = 0; r < N; ++r) {
            for (int c = 0; c < N; ++c) {
                // 1. Connect adjacent cells
                // Connect current cell's top (0) with cell above's bottom (2)
                if (r > 0) {
                    unite(get_idx(r, c, 0), get_idx(r - 1, c, 2));
                }
                // Connect current cell's left (3) with cell to left's right (1)
                if (c > 0) {
                    unite(get_idx(r, c, 3), get_idx(r, c - 1, 1));
                }

                // 2. Connect parts within the current cell based on its character
                if (grid[r][c] == ' ') {
                    // All 4 parts are connected
                    unite(get_idx(r, c, 0), get_idx(r, c, 1));
                    unite(get_idx(r, c, 1), get_idx(r, c, 2));
                    unite(get_idx(r, c, 2), get_idx(r, c, 3));
                } else if (grid[r][c] == '/') {
                    // Top (0) connects with Left (3)
                    // Right (1) connects with Bottom (2)
                    unite(get_idx(r, c, 0), get_idx(r, c, 3));
                    unite(get_idx(r, c, 1), get_idx(r, c, 2));
                } else { // grid[r][c] == '\\'
                    // Top (0) connects with Right (1)
                    // Bottom (2) connects with Left (3)
                    unite(get_idx(r, c, 0), get_idx(r, c, 1));
                    unite(get_idx(r, c, 2), get_idx(r, c, 3));
                }
            }
        }

        return count;
    }
};