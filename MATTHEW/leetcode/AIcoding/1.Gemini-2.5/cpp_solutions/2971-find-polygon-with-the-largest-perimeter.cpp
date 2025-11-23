#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long largestPerimeter(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());

        long long current_sum = 0;
        for (int num : nums) {
            current_sum += num;
        }

        for (int i = nums.size() - 1; i >= 2; --i) {
            if (current_sum - nums[i] > nums[i]) {
                return current_sum;
            }
            current_sum -= nums[i];
        }

        return -1;
    }
};