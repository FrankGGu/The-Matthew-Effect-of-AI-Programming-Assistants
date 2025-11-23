#include <vector>
#include <algorithm>

class Solution {
public:
    bool check(int max_amount, int k, const std::vector<int>& nums) {
        int robbed_count = 0;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] <= max_amount) {
                robbed_count++;
                i++; // Skip the next house as it's adjacent
            }
        }
        return robbed_count >= k;
    }

    int minCapability(std::vector<int>& nums, int k) {
        int low = 1; // Minimum possible capability (house amount is positive)
        int high = 1e9; // Maximum possible capability (max house amount is 10^9)
        int ans = high;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (check(mid, k, nums)) {
                ans = mid;
                high = mid - 1; // Try to find a smaller maximum amount
            } else {
                low = mid + 1; // Need a larger maximum amount
            }
        }
        return ans;
    }
};