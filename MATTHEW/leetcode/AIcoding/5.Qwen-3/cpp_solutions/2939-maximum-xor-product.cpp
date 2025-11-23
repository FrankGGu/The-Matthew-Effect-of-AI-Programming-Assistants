#include <vector>
#include <climits>
#include <cmath>

class Solution {
public:
    long long maximumXorProduct(long long a, long long b, std::vector<int>& nums) {
        long long res = 0;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            if (a > b) std::swap(a, b);
            if ((a ^ nums[i]) > a) {
                a ^= nums[i];
            } else if ((b ^ nums[i]) > b) {
                b ^= nums[i];
            }
        }
        return std::max(a, b);
    }
};