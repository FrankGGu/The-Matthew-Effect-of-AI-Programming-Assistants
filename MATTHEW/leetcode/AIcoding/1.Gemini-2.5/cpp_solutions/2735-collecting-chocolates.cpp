#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long minCost(std::vector<int>& nums, int x) {
        int n = nums.size();
        std::vector<long long> min_costs(n);
        for (int i = 0; i < n; ++i) {
            min_costs[i] = nums[i];
        }

        long long ans = std::accumulate(min_costs.begin(), min_costs.end(), 0LL);

        for (int k = 1; k < n; ++k) {
            long long current_collection_cost = 0;
            for (int i = 0; i < n; ++i) {
                min_costs[i] = std::min(min_costs[i], (long long)nums[(i - k + n) % n]);
                current_collection_cost += min_costs[i];
            }
            long long total_cost = (long long)k * x + current_collection_cost;
            ans = std::min(ans, total_cost);
        }

        return ans;
    }
};