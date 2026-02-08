#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> minOperations(std::vector<int>& nums) {
        int total_or = 0;
        for (int x : nums) {
            total_or |= x;
        }

        std::vector<int> ans(nums.size());
        for (size_t i = 0; i < nums.size(); ++i) {
            ans[i] = total_or;
        }

        return ans;
    }
};