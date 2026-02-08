#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int rangeSum(std::vector<int>& nums, int n, int left, int right) {
        std::vector<int> subarraySums;
        for (int i = 0; i < n; ++i) {
            int currentSum = 0;
            for (int j = i; j < n; ++j) {
                currentSum += nums[j];
                subarraySums.push_back(currentSum);
            }
        }

        std::sort(subarraySums.begin(), subarraySums.end());

        long long totalRangeSum = 0;
        long long MOD = 1e9 + 7;

        for (int i = left - 1; i < right; ++i) {
            totalRangeSum = (totalRangeSum + subarraySums[i]) % MOD;
        }

        return static_cast<int>(totalRangeSum);
    }
};