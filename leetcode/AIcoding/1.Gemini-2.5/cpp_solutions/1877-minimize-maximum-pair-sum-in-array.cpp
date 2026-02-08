#include <vector>
#include <algorithm>

class Solution {
public:
    int minPairSum(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());

        int max_pair_sum = 0;
        int left = 0;
        int right = nums.size() - 1;

        while (left < right) {
            max_pair_sum = std::max(max_pair_sum, nums[left] + nums[right]);
            left++;
            right--;
        }

        return max_pair_sum;
    }
};