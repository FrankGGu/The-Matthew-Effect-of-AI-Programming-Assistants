#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> restoreMatrix(std::vector<int>& rowSum, std::vector<int>& colSum) {
        int m = rowSum.size();
        int n = colSum.size();
        std::vector<std::vector<int>> matrix(m, std::vector<int>(n, 0));

        int i = 0, j = 0;
        while (i < m && j < n) {
            int val = std::min(rowSum[i], colSum[j]);
            matrix[i][j] = val;
            rowSum[i] -= val;
            colSum[j] -= val;

            if (rowSum[i] == 0) {
                i++;
            }
            if (colSum[j] == 0) {
                j++;
            }
        }

        return matrix;
    }
};