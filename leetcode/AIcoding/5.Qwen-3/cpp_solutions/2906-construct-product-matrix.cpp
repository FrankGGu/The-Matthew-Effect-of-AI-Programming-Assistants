#include <vector>
#include <iostream>

class Solution {
public:
    std::vector<int> distinctNumbers(std::vector<int>& nums) {
        std::vector<int> result;
        for (int i = 0; i < nums.size(); ++i) {
            bool isUnique = true;
            for (int j = 0; j < nums.size(); ++j) {
                if (i != j && nums[i] == nums[j]) {
                    isUnique = false;
                    break;
                }
            }
            if (isUnique) {
                result.push_back(nums[i]);
            }
        }
        return result;
    }
};