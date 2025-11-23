#include <vector>
#include <algorithm> // For std::max and std::min

class Solution {
public:
    int maxProduct(std::vector<int>& nums) {
        if (nums.empty()) {
            return 0;
        }

        // max_so_far stores the maximum product found so far
        long long max_so_far = nums[0];

        // max_ending_here stores the maximum product of a subarray ending at the current position
        long long max_ending_here = nums[0];

        // min_ending_here stores the minimum product of a subarray ending at the current position
        long long min_ending_here = nums[0];

        for (size_t i = 1; i < nums.size(); ++i) {
            long long current_num = nums[i];

            // A temporary variable to store the previous max_ending_here
            // because max_ending_here itself will be updated and its old value is needed for min_ending_here calculation
            long long temp_max_ending_here = max_ending_here;

            // The new max_ending_here could be:
            // 1. The current number itself (starting a new subarray)
            // 2. Product of current number and previous max_ending_here
            // 3. Product of current number and previous min_ending_here (if current_num is negative, this could become a large positive)
            max_ending_here = std::max({current_num, current_num * temp_max_ending_here, current_num * min_ending_here});

            // The new min_ending_here could be:
            // 1. The current number itself (starting a new subarray)
            // 2. Product of current number and previous max_ending_here (if current_num is negative, this could become a small negative)
            // 3. Product of current number and previous min_ending_here
            min_ending_here = std::min({current_num, current_num * temp_max_ending_here, current_num * min_ending_here});

            // Update the overall maximum product found
            max_so_far = std::max(max_so_far, max_ending_here);
        }

        return static_cast<int>(max_so_far);
    }
};