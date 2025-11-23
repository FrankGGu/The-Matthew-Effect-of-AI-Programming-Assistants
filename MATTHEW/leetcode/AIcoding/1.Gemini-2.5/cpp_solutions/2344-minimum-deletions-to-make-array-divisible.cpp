#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int minOperations(std::vector<int>& nums, std::vector<int>& numsDivide) {
        int common_divisor = numsDivide[0];
        for (size_t i = 1; i < numsDivide.size(); ++i) {
            common_divisor = std::gcd(common_divisor, numsDivide[i]);
        }

        std::sort(nums.begin(), nums.end());

        for (int i = 0; i < nums.size(); ++i) {
            if (common_divisor % nums[i] == 0) {
                return i;
            }
        }

        return -1;
    }
};