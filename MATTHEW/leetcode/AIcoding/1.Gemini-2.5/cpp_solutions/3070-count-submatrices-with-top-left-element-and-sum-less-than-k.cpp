#include <vector>
#include <numeric>

class Solution {
public:
    int countSubmatrices(std::vector<std::vector<int>>& grid, int k) {
        int m = grid.size();
        int n = grid[0].size();

        std::vector<std::vector<int>> ps(m + 1, std::vector<int>(n + 1, 0));
        int count = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                ps[i + 1][j + 1] = grid[i][j] + ps[i][j + 1] + ps[i + 1][j] - ps[i][j];
                if (ps[i + 1][j + 1] < k) {
                    count++;
                }
            }
        }

        return count;
    }
};