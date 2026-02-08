#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> findDuplicates(std::vector<int>& nums) {
        std::vector<int> result;
        for (int i = 0; i < nums.size(); ++i) {
            int index = abs(nums[i]) - 1;
            if (nums[index] < 0) {
                result.push_back(index + 1);
            }
            nums[index] = -nums[index];
        }
        return result;
    }
};