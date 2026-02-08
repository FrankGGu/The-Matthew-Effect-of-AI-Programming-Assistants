#include <vector>

class Solution {
private:
    bool isIncreasing(const std::vector<int>& nums, int start, int end) {
        if (start >= end) {
            return true;
        }
        for (int i = start; i < end; ++i) {
            if (nums[i] >= nums[i+1]) {
                return false;
            }
        }
        return true;
    }

public:
    bool canBeSplit(std::vector<int>& nums) {
        int n = nums.size();
        if (n < 2) {
            return false;
        }

        for (int i = 1; i < n; ++i) {
            bool left_is_increasing = isIncreasing(nums, 0, i - 1);
            bool right_is_increasing = isIncreasing(nums, i, n - 1);

            if (left_is_increasing && right_is_increasing) {
                return true;
            }
        }

        return false;
    }
};