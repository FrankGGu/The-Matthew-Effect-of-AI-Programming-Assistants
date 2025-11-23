#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    int minIncrementToMakeUnique(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());
        int increments = 0;
        for (int i = 1; i < nums.size(); ++i) {
            if (nums[i] <= nums[i - 1]) {
                increments += nums[i - 1] - nums[i] + 1;
                nums[i] = nums[i - 1] + 1;
            }
        }
        return increments;
    }
};