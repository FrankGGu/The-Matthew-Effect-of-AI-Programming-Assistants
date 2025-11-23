#include <vector>

class Solution {
public:
    bool isSpecialArray(std::vector<int>& nums) {
        for (int i = 0; i < nums.size(); ++i) {
            if (i % 2 == 0) { // Current index is even
                if (nums[i] % 2 != 0) { // Element at even index must be even
                    return false;
                }
            } else { // Current index is odd
                if (nums[i] % 2 == 0) { // Element at odd index must be odd
                    return false;
                }
            }
        }
        return true;
    }
};