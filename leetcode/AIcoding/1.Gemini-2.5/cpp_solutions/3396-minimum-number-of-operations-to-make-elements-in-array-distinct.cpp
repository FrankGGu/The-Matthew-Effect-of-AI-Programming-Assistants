#include <vector>
#include <algorithm>

class Solution {
public:
    long long minIncrementForUnique(std::vector<int>& nums) {
        if (nums.empty()) {
            return 0;
        }

        std::sort(nums.begin(), nums.end());

        long long operations = 0;

        for (int i = 1; i < nums.size(); ++i) {
            if (nums[i] <= nums[i-1]) {
                long long increment_needed = (long long)nums[i-1] + 1 - nums[i];
                operations += increment_needed;
                nums[i] = nums[i-1] + 1;
            }
        }

        return operations;
    }
};