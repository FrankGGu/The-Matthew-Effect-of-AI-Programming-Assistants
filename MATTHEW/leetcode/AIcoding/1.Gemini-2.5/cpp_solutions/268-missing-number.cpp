#include <vector>
#include <numeric>

class Solution {
public:
    int missingNumber(std::vector<int>& nums) {
        int n = nums.size();
        long long expectedSum = (long long)n * (n + 1) / 2;
        long long actualSum = std::accumulate(nums.begin(), nums.end(), 0LL);
        return static_cast<int>(expectedSum - actualSum);
    }
};