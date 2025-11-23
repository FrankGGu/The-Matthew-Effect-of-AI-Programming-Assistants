#include <vector>
#include <algorithm> // For std::min, std::max
#include <cstdlib>   // For std::abs
#include <climits>   // For LLONG_MAX

class Solution {
public:
    // Helper function to calculate the total cost for a given target value
    long long calculate_total_cost(int target_val, const std::vector<int>& nums, const std::vector<int>& cost) {
        long long current_total_cost = 0;
        for (int i = 0; i < nums.size(); ++i) {
            current_total_cost += (long long)std::abs(nums[i] - target_val) * cost[i];
        }
        return current_total_cost;
    }

    long long minCost(std::vector<int>& nums, std::vector<int>& cost) {
        int min_val = nums[0];
        int max_val = nums[0];
        for (int num : nums) {
            min_val = std::min(min_val, num);
            max_val = std::max(max_val, num);
        }

        long long overall_min_cost = LLONG_MAX;

        int left = min_val;
        int right = max_val;

        while (right - left >= 3) {
            int m1 = left + (right - left) / 3;
            int m2 = right - (right - left) / 3;

            long long cost1 = calculate_total_cost(m1, nums, cost);
            long long cost2 = calculate_total_cost(m2, nums, cost);

            overall_min_cost = std::min({overall_min_cost, cost1, cost2});

            if (cost1 < cost2) {
                right = m2;
            } else {
                left = m1;
            }
        }

        for (int i = left; i <= right; ++i) {
            overall_min_cost = std::min(overall_min_cost, calculate_total_cost(i, nums, cost));
        }

        return overall_min_cost;
    }
};