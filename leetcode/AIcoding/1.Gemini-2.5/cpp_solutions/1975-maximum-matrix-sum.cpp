#include <vector>
#include <cmath>
#include <algorithm>
#include <limits>

class Solution {
public:
    long long maxMatrixSum(std::vector<std::vector<int>>& matrix) {
        long long total_sum_abs = 0;
        int neg_count = 0;
        int min_abs_val = std::numeric_limits<int>::max();

        for (const auto& row : matrix) {
            for (int num : row) {
                if (num < 0) {
                    neg_count++;
                }
                total_sum_abs += std::abs(num);
                min_abs_val = std::min(min_abs_val, std::abs(num));
            }
        }

        if (neg_count % 2 == 0) {
            return total_sum_abs;
        } else {
            return total_sum_abs - 2 * min_abs_val;
        }
    }
};