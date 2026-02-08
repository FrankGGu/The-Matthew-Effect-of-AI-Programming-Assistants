#include <vector>
#include <numeric>
#include <algorithm>
#include <cmath>

class Solution {
public:
    bool check(int divisor, const std::vector<int>& nums, int threshold) {
        long long current_sum = 0;
        for (int num : nums) {
            current_sum += (num + divisor - 1) / divisor;
        }
        return current_sum <= threshold;
    }

    int smallestDivisor(std::vector<int>& nums, int threshold) {
        int low = 1;
        int high = 0;
        for (int num : nums) {
            if (num > high) {
                high = num;
            }
        }

        int ans = high;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (check(mid, nums, threshold)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }
};