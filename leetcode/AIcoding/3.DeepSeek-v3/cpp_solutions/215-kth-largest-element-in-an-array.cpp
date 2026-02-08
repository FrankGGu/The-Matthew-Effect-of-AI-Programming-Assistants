#include <vector>
#include <algorithm>

class Solution {
public:
    int findKthLargest(std::vector<int>& nums, int k) {
        std::nth_element(nums.begin(), nums.begin() + k - 1, nums.end(), std::greater<int>());
        return nums[k - 1];
    }
};