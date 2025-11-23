#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    int maxProductDifference(int a, int b, int c, int d) {
        std::vector<int> nums = {a, b, c, d};
        std::sort(nums.begin(), nums.end());
        return (nums[3] * nums[2]) - (nums[1] * nums[0]);
    }
};