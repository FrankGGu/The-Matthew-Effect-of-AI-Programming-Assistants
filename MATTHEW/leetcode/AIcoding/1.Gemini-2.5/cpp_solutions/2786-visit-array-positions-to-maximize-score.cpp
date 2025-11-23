#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    long long maxScore(std::vector<int>& nums, int x) {
        long long max_score_ending_even = LLONG_MIN;
        long long max_score_ending_odd = LLONG_MIN;

        // Initialize based on the first element nums[0]
        if (nums[0] % 2 == 0) { // nums[0] is even
            max_score_ending_even = nums[0];
        } else { // nums[0] is odd
            max_score_ending_odd = nums[0];
        }

        // Iterate from the second element
        for (int i = 1; i < nums.size(); ++i) {
            long long current_num = nums[i];
            long long new_max_score_ending_even = max_score_ending_even;
            long long new_max_score_ending_odd = max_score_ending_odd;

            if (current_num % 2 == 0) { // Current number is even
                // Option 1: Extend a path ending with an even number
                long long score_from_even = max_score_ending_even + current_num;
                // Option 2: Extend a path ending with an odd number (cost x)
                long long score_from_odd = max_score_ending_odd + current_num - x;

                // Update max_score_ending_even with the best option
                // We need to ensure max_score_ending_odd was reachable (not LLONG_MIN)
                if (max_score_ending_odd != LLONG_MIN) {
                    new_max_score_ending_even = std::max(score_from_even, score_from_odd);
                } else {
                    new_max_score_ending_even = score_from_even;
                }
            } else { // Current number is odd
                // Option 1: Extend a path ending with an odd number
                long long score_from_odd = max_score_ending_odd + current_num;
                // Option 2: Extend a path ending with an even number (cost x)
                long long score_from_even = max_score_ending_even + current_num - x;

                // Update max_score_ending_odd with the best option
                // We need to ensure max_score_ending_even was reachable (not LLONG_MIN)
                if (max_score_ending_even != LLONG_MIN) {
                    new_max_score_ending_odd = std::max(score_from_odd, score_from_even);
                } else {
                    new_max_score_ending_odd = score_from_odd;
                }
            }

            max_score_ending_even = new_max_score_ending_even;
            max_score_ending_odd = new_max_score_ending_odd;
        }

        return std::max(max_score_ending_even, max_score_ending_odd);
    }
};