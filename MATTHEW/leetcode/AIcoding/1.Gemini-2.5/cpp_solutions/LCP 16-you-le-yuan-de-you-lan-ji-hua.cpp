#include <vector>
#include <algorithm>
#include <climits> // For LLONG_MIN

class Solution {
public:
    long long maxScore(std::vector<int>& nums, int x) {
        // dp_even stores the maximum score ending with an even number.
        // dp_odd stores the maximum score ending with an odd number.
        // Initialize with LLONG_MIN to represent an unreachable state.
        long long dp_even = LLONG_MIN;
        long long dp_odd = LLONG_MIN;

        // The first element nums[0] is always visited.
        // Initialize dp states based on the parity of nums[0].
        if (nums[0] % 2 == 0) {
            dp_even = nums[0];
        } else {
            dp_odd = nums[0];
        }

        // Iterate from the second element to the end of the array.
        for (int i = 1; i < nums.size(); ++i) {
            long long current_num = nums[i];
            int current_parity = current_num % 2;

            // Store the dp values from the previous iteration to ensure correct updates.
            long long prev_dp_even = dp_even;
            long long prev_dp_odd = dp_odd;

            if (current_parity == 0) { // Current number is even
                // Option 1: Extend a path that ended with an even number.
                // This is only possible if prev_dp_even was reachable.
                if (prev_dp_even != LLONG_MIN) {
                    dp_even = std::max(dp_even, prev_dp_even + current_num);
                }
                // Option 2: Extend a path that ended with an odd number.
                // This incurs a cost 'x' because parities are different.
                // This is only possible if prev_dp_odd was reachable.
                if (prev_dp_odd != LLONG_MIN) {
                    dp_even = std::max(dp_even, prev_dp_odd + current_num - x);
                }
                // dp_odd remains unchanged for this iteration as current_num is even.
            } else { // Current number is odd
                // Option 1: Extend a path that ended with an odd number.
                // This is only possible if prev_dp_odd was reachable.
                if (prev_dp_odd != LLONG_MIN) {
                    dp_odd = std::max(dp_odd, prev_dp_odd + current_num);
                }
                // Option 2: Extend a path that ended with an even number.
                // This incurs a cost 'x' because parities are different.
                // This is only possible if prev_dp_even was reachable.
                if (prev_dp_even != LLONG_MIN) {
                    dp_odd = std::max(dp_odd, prev_dp_even + current_num - x);
                }
                // dp_even remains unchanged for this iteration as current_num is odd.
            }
        }

        // The maximum score will be the maximum of paths ending with an even or odd number.
        return std::max(dp_even, dp_odd);
    }
};