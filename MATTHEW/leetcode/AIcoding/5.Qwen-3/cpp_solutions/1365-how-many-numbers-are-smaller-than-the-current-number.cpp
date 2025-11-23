#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> smallerNumbersThanCurrent(const std::vector<int>& nums) {
        std::vector<int> result;
        for (int i = 0; i < nums.size(); ++i) {
            int count = 0;
            for (int j = 0; j < nums.size(); ++j) {
                if (nums[i] > nums[j]) {
                    ++count;
                }
            }
            result.push_back(count);
        }
        return result;
    }
};