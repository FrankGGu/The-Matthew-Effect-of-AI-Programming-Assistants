#include <vector>
#include <algorithm>

class Solution {
public:
    int alternatingSubarray(std::vector<int>& nums) {
        int n = nums.size();
        int max_len = 0;
        int current_len = 0;

        for (int i = 1; i < n; ++i) {
            if (current_len > 0 && nums[i] == nums[i - 2]) {
                current_len++;
            } else {
                if (nums[i] - nums[i - 1] == 1) {
                    current_len = 2;
                } else {
                    current_len = 0;
                }
            }
            max_len = std::max(max_len, current_len);
        }

        return max_len > 0 ? max_len : -1;
    }
};