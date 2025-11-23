#include <vector>
#include <algorithm>

class Solution {
public:
    int rob(std::vector<int>& nums) {
        int n = nums.size();
        if (n == 0) {
            return 0;
        }
        if (n == 1) {
            return nums[0];
        }

        int max1 = rob_range(nums, 0, n - 2);
        int max2 = rob_range(nums, 1, n - 1);

        return std::max(max1, max2);
    }

private:
    int rob_range(const std::vector<int>& nums, int start, int end) {
        int rob1 = 0;
        int rob2 = 0;
        for (int i = start; i <= end; ++i) {
            int temp = std::max(nums[i] + rob1, rob2);
            rob1 = rob2;
            rob2 = temp;
        }
        return rob2;
    }
};