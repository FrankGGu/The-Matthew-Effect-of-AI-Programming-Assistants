#include <vector>
#include <algorithm>

class Solution {
public:
    int maximumBeauty(std::vector<int>& nums, int k) {
        std::sort(nums.begin(), nums.end());
        int left = 0;
        int maxLength = 0;
        for (int right = 0; right < nums.size(); ++right) {
            while (nums[right] - nums[left] > 2 * k) {
                left++;
            }
            maxLength = std::max(maxLength, right - left + 1);
        }
        return maxLength;
    }
};