#include <vector>
#include <algorithm>

class Solution {
public:
    int numSubseq(std::vector<int>& nums, int target) {
        std::sort(nums.begin(), nums.end());
        int n = nums.size();
        long long count = 0;
        long long MOD = 1e9 + 7;

        std::vector<long long> powers(n);
        powers[0] = 1;
        for (int i = 1; i < n; ++i) {
            powers[i] = (powers[i-1] * 2) % MOD;
        }

        int left = 0;
        int right = n - 1;

        while (left <= right) {
            if (nums[left] + nums[right] <= target) {
                count = (count + powers[right - left]) % MOD;
                left++;
            } else {
                right--;
            }
        }

        return static_cast<int>(count);
    }
};