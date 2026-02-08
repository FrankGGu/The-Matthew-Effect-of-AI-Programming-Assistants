#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    int minDifference(std::vector<int>& nums) {
        int n = nums.size();

        if (n <= 4) {
            return 0;
        }

        std::sort(nums.begin(), nums.end());

        int min_diff = INT_MAX;

        // Case 1: Remove 3 largest elements
        // Remaining elements: nums[0]...nums[n-4]
        min_diff = std::min(min_diff, nums[n - 4] - nums[0]);

        // Case 2: Remove 2 largest and 1 smallest element
        // Remaining elements: nums[1]...nums[n-3]
        min_diff = std::min(min_diff, nums[n - 3] - nums[1]);

        // Case 3: Remove 1 largest and 2 smallest elements
        // Remaining elements: nums[2]...nums[n-2]
        min_diff = std::min(min_diff, nums[n - 2] - nums[2]);

        // Case 4: Remove 3 smallest elements
        // Remaining elements: nums[3]...nums[n-1]
        min_diff = std::min(min_diff, nums[n - 1] - nums[3]);

        return min_diff;
    }
};