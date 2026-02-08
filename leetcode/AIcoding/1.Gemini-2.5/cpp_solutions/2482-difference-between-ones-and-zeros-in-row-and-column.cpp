#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<std::vector<int>> onesMinusZeros(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        std::vector<int> onesRow(m, 0);
        std::vector<int> onesCol(n, 0);

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    onesRow[i]++;
                    onesCol[j]++;
                }
            }
        }

        std::vector<std::vector<int>> diff(m, std::vector<int>(n));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                // onesRow_i = onesRow[i]
                // zerosRow_i = n - onesRow[i]
                // onesCol_j = onesCol[j]
                // zerosCol_j = m - onesCol[j]
                // diff[i][j] = onesRow_i + onesCol_j - zerosRow_i - zerosCol_j
                // diff[i][j] = onesRow[i] + onesCol[j] - (n - onesRow[i]) - (m - onesCol[j])
                // diff[i][j] = onesRow[i] + onesCol[j] - n + onesRow[i] - m + onesCol[j]
                // diff[i][j] = 2 * onesRow[i] + 2 * onesCol[j] - n - m
                diff[i][j] = 2 * onesRow[i] + 2 * onesCol[j] - n - m;
            }
        }

        return diff;
    }
};