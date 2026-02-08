#include <vector>
#include <algorithm>
#include <functional>

class Solution {
public:
    int kthLargestValue(std::vector<std::vector<int>>& matrix, int k) {
        int m = matrix.size();
        int n = matrix[0].size();

        std::vector<std::vector<int>> dp(m, std::vector<int>(n));
        std::vector<int> xor_values;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int current_val = matrix[i][j];

                if (i > 0) {
                    current_val ^= dp[i-1][j];
                }
                if (j > 0) {
                    current_val ^= dp[i][j-1];
                }
                if (i > 0 && j > 0) {
                    current_val ^= dp[i-1][j-1];
                }

                dp[i][j] = current_val;
                xor_values.push_back(dp[i][j]);
            }
        }

        std::sort(xor_values.begin(), xor_values.end(), std::greater<int>());

        return xor_values[k-1];
    }
};