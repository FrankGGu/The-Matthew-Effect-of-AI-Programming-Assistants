#include <vector>
#include <algorithm>

class Solution {
public:
    double findMedianUnique(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());
        nums.erase(std::unique(nums.begin(), nums.end()), nums.end());
        int n = nums.size();
        if (n % 2 == 1) {
            return nums[n / 2];
        } else {
            return (nums[n / 2 - 1] + nums[n / 2]) / 2.0;
        }
    }
};