#include <vector>
#include <numeric>

class Solution {
public:
    bool canSplitArray(std::vector<int>& nums, int m) {
        int n = nums.size();

        if (n <= 2) {
            return true;
        }

        for (int i = 0; i < n - 1; ++i) {
            if (nums[i] + nums[i+1] >= m) {
                return true;
            }
        }

        return false;
    }
};