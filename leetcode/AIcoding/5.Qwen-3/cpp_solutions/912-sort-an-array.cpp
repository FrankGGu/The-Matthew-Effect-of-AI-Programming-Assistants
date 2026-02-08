#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> sortArray(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());
        return nums;
    }
};