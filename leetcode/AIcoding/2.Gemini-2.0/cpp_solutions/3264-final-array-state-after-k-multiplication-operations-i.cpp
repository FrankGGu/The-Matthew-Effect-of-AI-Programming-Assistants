#include <vector>

class Solution {
public:
    std::vector<int> getFinalState(int k, std::vector<int>& nums) {
        for (int i = 0; i < std::min((int)nums.size(), k); ++i) {
            nums[i] *= 2;
        }
        return nums;
    }
};