#include <vector>
#include <unordered_set>
#include <numeric>

class Solution {
public:
    bool findSubarrays(std::vector<int>& nums) {
        std::unordered_set<int> seen_sums;
        for (int i = 0; i < nums.size() - 1; ++i) {
            int current_sum = nums[i] + nums[i+1];
            if (seen_sums.count(current_sum)) {
                return true;
            }
            seen_sums.insert(current_sum);
        }
        return false;
    }
};