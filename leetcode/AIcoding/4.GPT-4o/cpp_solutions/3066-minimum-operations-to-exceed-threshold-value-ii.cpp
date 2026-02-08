#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    int minOperations(std::vector<int>& nums, int x) {
        int total = std::accumulate(nums.begin(), nums.end(), 0);
        int target = total - x;
        if (target < 0) return -1;

        int maxLen = -1, currentSum = 0;
        for (int left = 0, right = 0; right < nums.size(); right++) {
            currentSum += nums[right];
            while (currentSum > target && left <= right) {
                currentSum -= nums[left++];
            }
            if (currentSum == target) {
                maxLen = std::max(maxLen, right - left + 1);
            }
        }
        return maxLen == -1 ? -1 : nums.size() - maxLen;
    }
};