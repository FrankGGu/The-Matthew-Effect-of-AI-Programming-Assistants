#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    int threeSumClosest(std::vector<int>& nums, int target) {
        std::sort(nums.begin(), nums.end());
        int closest = INT_MAX;
        int minDiff = INT_MAX;

        for (int i = 0; i < nums.size() - 2; ++i) {
            int left = i + 1;
            int right = nums.size() - 1;

            while (left < right) {
                int sum = nums[i] + nums[left] + nums[right];
                int diff = std::abs(sum - target);

                if (diff < minDiff) {
                    minDiff = diff;
                    closest = sum;
                }

                if (sum < target) {
                    ++left;
                } else if (sum > target) {
                    --right;
                } else {
                    return sum;
                }
            }
        }
        return closest;
    }
};