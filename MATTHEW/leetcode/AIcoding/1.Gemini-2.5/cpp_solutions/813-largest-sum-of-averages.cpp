#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    double largestSumOfAverages(std::vector<int>& nums, int k) {
        int n = nums.size();

        std::vector<double> prefix_sum(n + 1, 0.0);
        for (int i = 0; i < n; ++i) {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i];
        }

        std::vector<std::vector<double>> dp(n + 1, std::vector<double>(k + 1, 0.0));

        // Base case: j = 1 partition
        // dp[i][1] is the average of the first i elements (nums[0]...nums[i-1])
        for (int i = 1; i <= n; ++i) {
            dp[i][1] = prefix_sum[i] / i;
        }

        // Fill DP table for j partitions
        // j ranges from 2 to k
        for (int j = 2; j <= k; ++j) {
            // i ranges from j to n. We need at least j elements to form j partitions.
            for (int i = j; i <= n; ++i) {
                // p is the split point. The (j-1)-th partition ends at index p-1.
                // The j-th partition starts at index p and ends at index i-1.
                // p must be at least j-1 (to have j-1 elements for the first j-1 partitions).
                // p must be less than i (to leave at least one element for the j-th partition).
                for (int p = j - 1; p < i; ++p) {
                    double current_segment_sum = prefix_sum[i] - prefix_sum[p];
                    double current_segment_length = i - p;
                    dp[i][j] = std::max(dp[i][j], dp[p][j - 1] + current_segment_sum / current_segment_length);
                }
            }
        }

        return dp[n][k];
    }
};