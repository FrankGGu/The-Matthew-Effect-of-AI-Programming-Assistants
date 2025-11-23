#include <vector>

class Solution {
public:
    long long numberOfRightTriangles(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        std::vector<int> row_ones(m, 0);
        std::vector<int> col_ones(n, 0);

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    row_ones[i]++;
                    col_ones[j]++;
                }
            }
        }

        long long total_triangles = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    total_triangles += static_cast<long long>(row_ones[i] - 1) * (col_ones[j] - 1);
                }
            }
        }

        return total_triangles;
    }
};