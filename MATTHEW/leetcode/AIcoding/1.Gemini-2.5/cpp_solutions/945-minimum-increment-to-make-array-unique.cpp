#include <vector>
#include <algorithm>

class Solution {
public:
    int minIncrementForUnique(std::vector<int>& nums) {
        if (nums.empty()) {
            return 0;
        }

        std::sort(nums.begin(), nums.end());

        long long moves = 0;
        for (int i = 1; i < nums.size(); ++i) {
            if (nums[i] <= nums[i - 1]) {
                int increment = nums[i - 1] + 1 - nums[i];
                moves += increment;
                nums[i] = nums[i - 1] + 1;
            }
        }

        return static_cast<int>(moves);
    }
};