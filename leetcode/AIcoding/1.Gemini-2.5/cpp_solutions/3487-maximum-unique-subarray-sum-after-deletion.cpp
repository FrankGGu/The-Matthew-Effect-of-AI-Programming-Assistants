#include <vector>
#include <unordered_set>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int maximumUniqueSubarray(std::vector<int>& nums) {
        int max_sum = 0;
        int current_sum = 0;
        std::unordered_set<int> seen;
        int left = 0;

        for (int right = 0; right < nums.size(); ++right) {
            while (seen.count(nums[right])) {
                current_sum -= nums[left];
                seen.erase(nums[left]);
                left++;
            }
            current_sum += nums[right];
            seen.insert(nums[right]);
            max_sum = std::max(max_sum, current_sum);
        }

        return max_sum;
    }
};