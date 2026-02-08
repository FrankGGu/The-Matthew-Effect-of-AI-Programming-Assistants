#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    int getMaximumGenerated(std::vector<int>& nums) {
        if (nums.empty()) return 0;
        if (nums.size() == 1) return nums[0];

        nums[0] = 0;
        nums[1] = 1;

        for (int i = 2; i < nums.size(); ++i) {
            if (i % 2 == 0) {
                nums[i] = nums[i / 2];
            } else {
                nums[i] = nums[i / 2] + nums[i / 2 + 1];
            }
        }

        return *std::max_element(nums.begin(), nums.end());
    }
};