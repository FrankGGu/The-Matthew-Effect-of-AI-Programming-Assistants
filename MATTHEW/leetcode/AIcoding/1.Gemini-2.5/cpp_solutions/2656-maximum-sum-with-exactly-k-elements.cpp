#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    long long maximizeSum(std::vector<int>& nums, int k) {
        int max_val = 0;
        for (int num : nums) {
            if (num > max_val) {
                max_val = num;
            }
        }

        long long sum = 0;
        sum = (long long)k * max_val + (long long)k * (k - 1) / 2;

        return sum;
    }
};