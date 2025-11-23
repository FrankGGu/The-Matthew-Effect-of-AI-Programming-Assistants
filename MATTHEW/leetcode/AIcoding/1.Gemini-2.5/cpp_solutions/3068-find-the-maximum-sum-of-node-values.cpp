#include <vector>
#include <numeric>
#include <algorithm>
#include <climits> // For LLONG_MAX, LLONG_MIN

class Solution {
public:
    long long maximumValueSum(std::vector<int>& nums, int k, std::vector<std::vector<int>>& edges) {
        long long total_sum = 0;
        long long current_additional_gain = 0;
        int count_positive_diffs = 0;
        long long min_positive_diff = LLONG_MAX;
        long long max_negative_diff = LLONG_MIN;

        for (int x : nums) {
            total_sum += x;
            long long diff = (long long)(x ^ k) - x;

            if (diff > 0) {
                current_additional_gain += diff;
                count_positive_diffs++;
                min_positive_diff = std::min(min_positive_diff, diff);
            } else { // diff <= 0
                max_negative_diff = std::max(max_negative_diff, diff);
            }
        }

        if (count_positive_diffs % 2 == 0) {
            return total_sum + current_additional_gain;
        } else {
            // Odd number of positive diffs.
            // We must change one choice to make the count even.
            // Option 1: Don't pick the smallest positive diff.
            // This is always possible since count_positive_diffs is odd, so there's at least one positive diff.
            long long option1_gain = current_additional_gain - min_positive_diff;

            // Option 2: Pick the largest negative diff (if any exist).
            long long option2_gain = LLONG_MIN; 
            if (max_negative_diff != LLONG_MIN) { // Check if there was any negative diff
                option2_gain = current_additional_gain + max_negative_diff;
            }

            return total_sum + std::max(option1_gain, option2_gain);
        }
    }
};