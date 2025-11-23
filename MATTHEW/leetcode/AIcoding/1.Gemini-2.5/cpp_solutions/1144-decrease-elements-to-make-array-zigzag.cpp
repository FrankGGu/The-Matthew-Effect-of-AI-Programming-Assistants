#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    long long calculateCost(const std::vector<int>& original_nums, bool start_with_peak) {
        long long cost = 0;
        std::vector<int> nums = original_nums; // Create a mutable copy
        int n = nums.size();

        for (int i = 0; i < n; ++i) {
            bool should_be_peak = (i % 2 == 0 && start_with_peak) || (i % 2 == 1 && !start_with_peak);

            if (should_be_peak) {
                // Current element nums[i] should be a peak: nums[i] > nums[i-1] and nums[i] > nums[i+1]
                int left_val = (i > 0) ? nums[i-1] : -1; // Use -1 as a very small value for non-existent neighbor
                int right_val = (i < n - 1) ? nums[i+1] : -1; // Use -1 as a very small value for non-existent neighbor

                int max_neighbor = std::max(left_val, right_val);

                if (nums[i] <= max_neighbor) {
                    long long moves = (long long)max_neighbor - nums[i] + 1;
                    cost += moves;
                    nums[i] -= moves; // Decrease nums[i] to be max_neighbor - 1
                }
            } else {
                // Current element nums[i] should be a valley: nums[i] < nums[i-1] and nums[i] < nums[i+1]
                int left_val = (i > 0) ? nums[i-1] : INT_MAX; // Use INT_MAX as a very large value for non-existent neighbor
                int right_val = (i < n - 1) ? nums[i+1] : INT_MAX; // Use INT_MAX as a very large value for non-existent neighbor

                int min_neighbor = std::min(left_val, right_val);

                if (nums[i] >= min_neighbor) {
                    long long moves = (long long)nums[i] - min_neighbor + 1;
                    cost += moves;
                    nums[i] -= moves; // Decrease nums[i] to be min_neighbor - 1
                }
            }
        }
        return cost;
    }

    int movesToMakeZigzag(std::vector<int>& nums) {
        if (nums.size() <= 1) {
            return 0;
        }

        // Scenario 1: Even indices are peaks (nums[0] > nums[1] < nums[2] > ...)
        long long cost1 = calculateCost(nums, true);

        // Scenario 2: Odd indices are peaks (nums[0] < nums[1] > nums[2] < ...)
        long long cost2 = calculateCost(nums, false);

        return std::min(cost1, cost2);
    }
};