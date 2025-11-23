#include <vector>
#include <algorithm>
#include <numeric>
#include <cmath> // For std::abs

class Solution {
public:
    long long minCost(std::vector<int>& nums, std::vector<int>& cost) {
        int n = nums.size();
        std::vector<std::pair<int, int>> pairs(n);
        for (int i = 0; i < n; ++i) {
            pairs[i] = {nums[i], cost[i]};
        }

        std::sort(pairs.begin(), pairs.end());

        long long total_cost_sum = 0;
        for (int i = 0; i < n; ++i) {
            total_cost_sum += pairs[i].second;
        }

        long long current_cost_sum = 0;
        int target_median_val = 0;

        for (int i = 0; i < n; ++i) {
            current_cost_sum += pairs[i].second;
            if (current_cost_sum * 2 >= total_cost_sum) {
                target_median_val = pairs[i].first;
                break;
            }
        }

        long long ans = 0;
        for (int i = 0; i < n; ++i) {
            ans += static_cast<long long>(std::abs(nums[i] - target_median_val)) * cost[i];
        }

        return ans;
    }
};