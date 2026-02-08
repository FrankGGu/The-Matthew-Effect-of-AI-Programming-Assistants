#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    int minimumSum(std::vector<int>& nums) {
        int n = nums.size();
        int min_sum = std::numeric_limits<int>::max();

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                for (int k = j + 1; k < n; ++k) {
                    if (nums[i] < nums[j] && nums[k] < nums[j]) {
                        min_sum = std::min(min_sum, nums[i] + nums[j] + nums[k]);
                    }
                }
            }
        }

        if (min_sum == std::numeric_limits<int>::max()) {
            return -1;
        } else {
            return min_sum;
        }
    }
};