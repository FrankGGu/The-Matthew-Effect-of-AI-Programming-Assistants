#include <vector>
#include <unordered_map>

class Solution {
public:
    int numSubmatrixSumTarget(std::vector<std::vector<int>>& matrix, int target) {
        int rows = matrix.size();
        int cols = matrix[0].size();
        int count = 0;

        for (int r1 = 0; r1 < rows; ++r1) {
            std::vector<int> col_sums(cols, 0);
            for (int r2 = r1; r2 < rows; ++r2) {
                for (int c = 0; c < cols; ++c) {
                    col_sums[c] += matrix[r2][c];
                }

                std::unordered_map<int, int> prefix_sum_counts;
                prefix_sum_counts[0] = 1;
                int current_sum = 0;
                for (int sum : col_sums) {
                    current_sum += sum;
                    if (prefix_sum_counts.count(current_sum - target)) {
                        count += prefix_sum_counts[current_sum - target];
                    }
                    prefix_sum_counts[current_sum]++;
                }
            }
        }
        return count;
    }
};