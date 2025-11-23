#include <vector>
#include <algorithm>

class Solution {
public:
    int maxAscendingSum(std::vector<int>& nums) {
        if (nums.empty()) {
            return 0;
        }

        int max_sum = nums[0];
        int current_sum = nums[0];

        for (int i = 1; i < nums.size(); ++i) {
            if (nums[i] > nums[i - 1]) {
                current_sum += nums[i];
            } else {
                current_sum = nums[i];
            }
            max_sum = std::max(max_sum, current_sum);
        }

        return max_sum;
    }
};