#include <vector>
#include <algorithm>
#include <cmath>
#include <numeric>

class Solution {
public:
    int minMoves2(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());
        int n = nums.size();
        int median = nums[n / 2];
        long long moves = 0;
        for (int num : nums) {
            moves += std::abs(num - median);
        }
        return static_cast<int>(moves);
    }
};