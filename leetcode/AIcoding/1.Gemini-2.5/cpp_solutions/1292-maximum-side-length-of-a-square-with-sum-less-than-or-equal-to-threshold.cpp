#include <vector>
#include <algorithm>

class Solution {
public:
    int maxSideLength(std::vector<std::vector<int>>& mat, int threshold) {
        int rows = mat.size();
        if (rows == 0) {
            return 0;
        }
        int cols = mat[0].size();
        if (cols == 0) {
            return 0;
        }

        std::vector<std::vector<int>> P(rows + 1, std::vector<int>(cols + 1, 0));

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                P[i + 1][j + 1] = mat[i][j] + P[i][j + 1] + P[i + 1][j] - P[i][j];
            }
        }

        auto getSum = [&](int r1, int c1, int r2, int c2) {
            return P[r2 + 1][c2 + 1] - P[r1][c2 + 1] - P[r2 + 1][c1] + P[r1][c1];
        };

        auto check = [&](int k) {
            if (k == 0) {
                return true;
            }
            for (int r = 0; r <= rows - k; ++r) {
                for (int c = 0; c <= cols - k; ++c) {
                    if (getSum(r, c, r + k - 1, c + k - 1) <= threshold) {
                        return true;
                    }
                }
            }
            return false;
        };

        int left = 0;
        int right = std::min(rows, cols);
        int max_k = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (check(mid)) {
                max_k = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return max_k;
    }
};