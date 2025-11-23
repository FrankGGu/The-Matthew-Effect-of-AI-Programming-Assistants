#include <vector>
#include <algorithm> // For std::max
#include <limits>    // For std::numeric_limits

class Solution {
public:
    long long maximizeTotalCost(std::vector<int>& nums) {
        int n = nums.size();
        if (n == 0) {
            return 0;
        }

        // prev_pos_cost: maximum total cost of partition ending at previous index (i-1),
        // where nums[i-1] is added (at an even index in its subarray).
        // prev_neg_cost: maximum total cost of partition ending at previous index (i-1),
        // where nums[i-1] is subtracted (at an odd index in its subarray).

        // Base case for i = 0
        // nums[0] must start a new subarray, so it's at an even index (0).
        long long prev_pos_cost = nums[0];
        // nums[0] cannot be at an odd index if it's the first element.
        // Initialize with a very small number to ensure it's not chosen unless a valid path exists.
        long long prev_neg_cost = std::numeric_limits<long long>::min() / 2; 

        for (int i = 1; i < n; ++i) {
            long long current_num = nums[i];

            // Calculate current_pos_cost: nums[i] is added (at an even index in its subarray).
            // This can happen in two ways:
            // 1. nums[i] starts a new subarray. The cost up to i-1 is max(prev_pos_cost, prev_neg_cost).
            //    Then add current_num as it's the first element (even index 0) of its new subarray.
            // 2. nums[i] extends an existing subarray where nums[i-1] was subtracted (odd index).
            //    The cost up to i-1 is prev_neg_cost. Then add current_num as it's at an even index.
            // Both cases are covered by taking the maximum of the prior states and adding current_num.
            long long current_pos_cost = std::max(prev_pos_cost, prev_neg_cost) + current_num;

            // Calculate current_neg_cost: nums[i] is subtracted (at an odd index in its subarray).
            // This can only happen if nums[i] extends an existing subarray where nums[i-1] was added (even index).
            // The cost up to i-1 is prev_pos_cost. Then subtract current_num as it's at an odd index.
            // nums[i] cannot start a new subarray and be at an odd index.
            long long current_neg_cost = prev_pos_cost - current_num;

            // Update for the next iteration
            prev_pos_cost = current_pos_cost;
            prev_neg_cost = current_neg_cost;
        }

        // The final answer is the maximum of the two possibilities for the last element.
        return std::max(prev_pos_cost, prev_neg_cost);
    }
};