#include <vector>
#include <utility>

class Solution {
public:
    void moveZeroes(std::vector<int>& nums) {
        int insertPos = 0;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] != 0) {
                std::swap(nums[insertPos++], nums[i]);
            }
        }
    }
};