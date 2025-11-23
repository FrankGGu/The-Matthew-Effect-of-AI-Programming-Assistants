#include <vector>
#include <algorithm>

class Solution {
public:
    int findFinalValue(std::vector<int>& nums, int original) {
        std::sort(nums.begin(), nums.end());
        for (int num : nums) {
            if (num == original) {
                original *= 2;
            }
        }
        return original;
    }
};