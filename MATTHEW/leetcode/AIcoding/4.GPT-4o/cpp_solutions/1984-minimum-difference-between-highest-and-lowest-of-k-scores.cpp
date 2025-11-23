#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    int minimumDifference(std::vector<int>& nums, int k) {
        std::sort(nums.begin(), nums.end());
        int n = nums.size();
        int minDiff = INT_MAX;

        for (int i = 0; i + k - 1 < n; i++) {
            minDiff = std::min(minDiff, nums[i + k - 1] - nums[i]);
        }

        return minDiff;
    }
};