#include <vector>
#include <cmath>

class Solution {
public:
    std::vector<std::vector<int>> onesMinusZeros(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        std::vector<int> rowOnes(m, 0);
        std::vector<int> colOnes(n, 0);

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                rowOnes[i] += grid[i][j];
                colOnes[j] += grid[i][j];
            }
        }

        std::vector<std::vector<int>> result(m, std::vector<int>(n, 0));
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                result[i][j] = 2 * (rowOnes[i] + colOnes[j]) - (n + m);
            }
        }

        return result;
    }
};