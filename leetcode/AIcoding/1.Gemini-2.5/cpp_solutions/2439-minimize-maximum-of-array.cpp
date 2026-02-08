#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int minimizeArrayValue(std::vector<int>& nums) {
        long long prefixSum = 0;
        long long result = 0;
        for (int i = 0; i < nums.size(); ++i) {
            prefixSum += nums[i];
            result = std::max(result, (prefixSum + i) / (i + 1));
        }
        return static_cast<int>(result);
    }
};