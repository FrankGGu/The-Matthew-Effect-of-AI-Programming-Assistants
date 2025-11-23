#include <vector>
#include <algorithm>

class Solution {
public:
    int numSubmat(std::vector<std::vector<int>>& mat) {
        int m = mat.size();
        if (m == 0) {
            return 0;
        }
        int n = mat[0].size();
        if (n == 0) {
            return 0;
        }

        int total_submatrices = 0;

        std::vector<int> heights(n, 0);

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (mat[i][j] == 1) {
                    heights[j]++;
                } else {
                    heights[j] = 0;
                }
            }

            for (int j = 0; j < n; ++j) {
                if (heights[j] == 0) {
                    continue;
                }
                int min_h = heights[j];
                for (int k = j; k >= 0; --k) {
                    min_h = std::min(min_h, heights[k]);
                    total_submatrices += min_h;
                }
            }
        }
        return total_submatrices;
    }
};