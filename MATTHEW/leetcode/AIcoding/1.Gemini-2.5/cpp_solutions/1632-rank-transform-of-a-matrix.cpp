#include <vector>
#include <algorithm>
#include <map>
#include <numeric>

struct Cell {
    int val;
    int r;
    int c;
};

bool compareCells(const Cell& a, const Cell& b) {
    return a.val < b.val;
}

class UnionFind {
public:
    std::vector<int> parent;
    UnionFind(int n) {
        parent.resize(n);
        std::iota(parent.begin(), parent.end(), 0); // Initialize parent[i] = i
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
            parent[root_i] = root_j;
        }
    }
};

class Solution {
public:
    std::vector<std::vector<int>> matrixRankTransform(std::vector<std::vector<int>>& matrix) {
        int m = matrix.size();
        int n = matrix[0].size();

        std::vector<Cell> cells;
        cells.reserve(m * n);
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                cells.push_back({matrix[i][j], i, j});
            }
        }

        std::sort(cells.begin(), cells.end(), compareCells);

        std::vector<std::vector<int>> rank(m, std::vector<int>(n));
        std::vector<int> row_max_rank(m, 0);
        std::vector<int> col_max_rank(n, 0);

        int current_idx = 0;
        while (current_idx < cells.size()) {
            int value = cells[current_idx].val;
            int group_start_idx = current_idx;
            while (current_idx < cells.size() && cells[current_idx].val == value) {
                current_idx++;
            }
            // Cells from group_start_idx to current_idx-1 form the current group with value 'value'

            int group_size = current_idx - group_start_idx;
            UnionFind uf(group_size);

            // Maps to store the first index in the current group for a given row/column
            // Used to connect cells in the same row/column within this group
            std::map<int, int> row_to_first_group_idx; 
            std::map<int, int> col_to_first_group_idx;

            for (int i = 0; i < group_size; ++i) {
                int original_cell_list_idx = group_start_idx + i;
                int r = cells[original_cell_list_idx].r;
                int c = cells[original_cell_list_idx].c;

                if (row_to_first_group_idx.count(r)) {
                    uf.unite(i, row_to_first_group_idx[r]);
                } else {
                    row_to_first_group_idx[r] = i;
                }

                if (col_to_first_group_idx.count(c)) {
                    uf.unite(i, col_to_first_group_idx[c]);
                } else {
                    col_to_first_group_idx[c] = i;
                }
            }

            // Calculate the maximum previous rank for each connected component
            // A map from Union-Find root index (within the current group) to the max rank
            std::map<int, int> component_max_prev_rank; 

            for (int i = 0; i < group_size; ++i) {
                int original_cell_list_idx = group_start_idx + i;
                int r = cells[original_cell_list_idx].r;
                int c = cells[original_cell_list_idx].c;
                int root = uf.find(i);

                // Initialize if not present, then take max
                if (component_max_prev_rank.find(root) == component_max_prev_rank.end()) {
                    component_max_prev_rank[root] = 0;
                }
                component_max_prev_rank[root] = std::max({component_max_prev_rank[root], row_max_rank[r], col_max_rank[c]});
            }

            // Assign ranks and update row_max_rank/col_max_rank
            for (int i = 0; i < group_size; ++i) {
                int original_cell_list_idx = group_start_idx + i;
                int r = cells[original_cell_list_idx].r;
                int c = cells[original_cell_list_idx].c;
                int root = uf.find(i);

                int current_cell_rank = component_max_prev_rank[root] + 1;
                rank[r][c] = current_cell_rank;

                row_max_rank[r] = std::max(row_max_rank[r], current_cell_rank);
                col_max_rank[c] = std::max(col_max_rank[c], current_cell_rank);
            }
        }

        return rank;
    }
};