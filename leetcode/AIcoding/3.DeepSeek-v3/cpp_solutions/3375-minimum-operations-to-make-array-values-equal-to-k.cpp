#include <vector>
#include <algorithm>

class Solution {
public:
    long long minOperationsToMakeMedianK(std::vector<int>& nums, int k) {
        int n = nums.size();
        std::sort(nums.begin(), nums.end());
        long long res = 0;
        int medianPos = n / 2;

        if (nums[medianPos] == k) {
            return 0;
        } else if (nums[medianPos] < k) {
            for (int i = medianPos; i < n && nums[i] < k; ++i) {
                res += k - nums[i];
            }
        } else {
            for (int i = medianPos; i >= 0 && nums[i] > k; --i) {
                res += nums[i] - k;
            }
        }

        return res;
    }
};