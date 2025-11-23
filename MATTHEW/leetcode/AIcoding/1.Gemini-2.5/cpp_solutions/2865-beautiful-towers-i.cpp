#include <vector>
#include <algorithm> // For std::min and std::max

class Solution {
public:
    long long maximumSumOfHeights(std::vector<int>& maxHeights) {
        int n = maxHeights.size();
        long long max_total_sum = 0;

        for (int p = 0; p < n; ++p) {
            long long current_sum = 0;

            // Calculate sum for the left side (including peak)
            long long current_h_left = maxHeights[p];
            current_sum += current_h_left;
            for (int i = p - 1; i >= 0; --i) {
                current_h_left = std::min(current_h_left, (long long)maxHeights[i]);
                current_sum += current_h_left;
            }

            // Calculate sum for the right side (excluding peak, as it's already counted)
            long long current_h_right = maxHeights[p];
            for (int i = p + 1; i < n; ++i) {
                current_h_right = std::min(current_h_right, (long long)maxHeights[i]);
                current_sum += current_h_right;
            }

            max_total_sum = std::max(max_total_sum, current_sum);
        }

        return max_total_sum;
    }
};