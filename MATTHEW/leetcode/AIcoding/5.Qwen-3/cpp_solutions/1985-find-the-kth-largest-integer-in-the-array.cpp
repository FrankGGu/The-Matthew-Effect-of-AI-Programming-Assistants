#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    int kthLargestInteger(std::vector<int>& nums, int k) {
        std::sort(nums.begin(), nums.end(), std::greater<int>());
        return nums[k - 1];
    }
};