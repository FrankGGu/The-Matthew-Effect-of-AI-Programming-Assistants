#include <vector>
#include <algorithm>

class Solution {
public:
    int largestSubmatrix(std::vector<std::vector<int>>& matrix) {
        int m = matrix.size();
        if (m == 0) {
            return 0;
        }
        int n = matrix[0].size();
        int maxArea = 0;

        for (int i = 1; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (matrix[i][j] == 1) {
                    matrix[i][j] += matrix[i - 1][j];
                }
            }
        }

        for (int i = 0; i < m; ++i) {
            std::sort(matrix[i].begin(), matrix[i].end());
            for (int j = 0; j < n; ++j) {
                int height = matrix[i][j];
                int width = n - j;
                maxArea = std::max(maxArea, height * width);
            }
        }

        return maxArea;
    }
};