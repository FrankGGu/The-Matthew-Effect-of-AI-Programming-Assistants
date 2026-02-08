#include <vector>
#include <algorithm>
#include <cmath>

class Solution {
public:
    int maximumStrongPairXor(std::vector<int>& nums) {
        int max_xor_sum = 0;
        int n = nums.size();

        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                int val1 = nums[i];
                int val2 = nums[j];

                if (std::abs(val1 - val2) <= std::min(val1, val2)) {
                    max_xor_sum = std::max(max_xor_sum, val1 ^ val2);
                }
            }
        }
        return max_xor_sum;
    }
};