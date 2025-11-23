#include <vector>
#include <algorithm> // For std::sort, std::lower_bound, std::upper_bound
#include <iterator>  // For std::distance

class Solution {
public:
    long long countFairPairs(std::vector<int>& nums, int lower, int upper) {
        std::sort(nums.begin(), nums.end());
        long long count = 0;
        int n = nums.size();

        for (int i = 0; i < n; ++i) {
            // For each nums[i], we need to find j > i such that:
            // lower <= nums[i] + nums[j] <= upper
            // This is equivalent to:
            // lower - nums[i] <= nums[j] <= upper - nums[i]

            // We search for nums[j] in the subarray nums[i+1 ... n-1].
            // Find the first element nums[j] that is greater than or equal to (lower - nums[i]).
            auto it_lower = std::lower_bound(nums.begin() + i + 1, nums.end(), lower - nums[i]);

            // Find the first element nums[j] that is strictly greater than (upper - nums[i]).
            auto it_upper = std::upper_bound(nums.begin() + i + 1, nums.end(), upper - nums[i]);

            // The number of elements nums[j] that satisfy the condition for the current nums[i]
            // is the distance between it_lower and it_upper.
            count += std::distance(it_lower, it_upper);
        }

        return count;
    }
};