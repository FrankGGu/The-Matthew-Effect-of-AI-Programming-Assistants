#include <vector>
#include <algorithm>
#include <numeric>

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
        int weighted_median = -1;

        for (int i = 0; i < n; ++i) {
            current_cost_sum += pairs[i].second;
            if (current_cost_sum * 2 >= total_cost_sum) {
                weighted_median = pairs[i].first;
                break;
            }
        }

        long long min_total_cost = 0;
        for (int i = 0; i < n; ++i) {
            min_total_cost += (long long)pairs[i].second * std::abs(pairs[i].first - weighted_median);
        }

        return min_total_cost;
    }
};