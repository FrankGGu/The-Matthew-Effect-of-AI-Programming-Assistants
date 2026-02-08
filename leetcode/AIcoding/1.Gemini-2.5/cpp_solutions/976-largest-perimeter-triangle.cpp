#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    int largestPerimeter(std::vector<int>& nums) {
        std::sort(nums.rbegin(), nums.rend());

        for (int i = 0; i <= (int)nums.size() - 3; ++i) {
            if (nums[i+1] + nums[i+2] > nums[i]) {
                return nums[i] + nums[i+1] + nums[i+2];
            }
        }
        return 0;
    }
};