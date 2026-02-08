#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int findGCD(std::vector<int>& nums) {
        auto minmax_pair = std::minmax_element(nums.begin(), nums.end());
        int min_val = *minmax_pair.first;
        int max_val = *minmax_pair.second;
        return std::gcd(min_val, max_val);
    }
};