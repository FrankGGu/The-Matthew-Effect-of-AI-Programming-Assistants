#include <vector>
#include <algorithm> // For std::sort, std::min
#include <climits>   // For INT_MAX

class Solution {
public:
    int findTheValueOfPartition(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());

        int n = nums.size();
        int min_diff = INT_MAX;

        for (int i = 0; i < n - 1; ++i) {
            min_diff = std::min(min_diff, nums[i + 1] - nums[i]);
        }

        return min_diff;
    }
};