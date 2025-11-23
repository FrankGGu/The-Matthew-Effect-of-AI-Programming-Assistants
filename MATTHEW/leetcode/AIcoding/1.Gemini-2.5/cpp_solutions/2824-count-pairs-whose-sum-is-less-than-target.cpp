#include <vector>
#include <algorithm>

class Solution {
public:
    int countPairs(std::vector<int>& nums, int target) {
        std::sort(nums.begin(), nums.end());
        int count = 0;
        int left = 0;
        int right = nums.size() - 1;

        while (left < right) {
            if (nums[left] + nums[right] < target) {
                count += (right - left);
                left++;
            } else {
                right--;
            }
        }
        return count;
    }
};