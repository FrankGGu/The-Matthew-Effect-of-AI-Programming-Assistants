#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int splitArray(std::vector<int>& nums, int m) {
        long long low = 0;
        long long high = 0;
        for (int num : nums) {
            low = std::max(low, (long long)num);
            high += num;
        }

        long long ans = high;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            if (canSplit(nums, m, mid)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return (int)ans;
    }

private:
    bool canSplit(const std::vector<int>& nums, int m, long long maxSum) {
        int splits = 1;
        long long currentSum = 0;
        for (int num : nums) {
            if (currentSum + num > maxSum) {
                splits++;
                currentSum = num;
            } else {
                currentSum += num;
            }
        }
        return splits <= m;
    }
};