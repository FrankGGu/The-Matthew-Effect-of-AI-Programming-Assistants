#include <vector>
#include <numeric>
#include <algorithm>
#include <unordered_map>

class Solution {
public:
    int minimumIncompatibility(std::vector<int>& nums, int k) {
        int n = nums.size();
        int group_size = n / k;

        std::unordered_map<int, int> counts;
        for (int num : nums) {
            counts[num]++;
            if (counts[num] > k) {
                return -1;
            }
        }

        std::sort(nums.begin(), nums.end());

        std::vector<int> group_costs(1 << n, -1);
        for (int mask = 0; mask < (1 << n); ++mask) {
            if (__builtin_popcount(mask) != group_size) {
                continue;
            }

            int min_val = -1, max_val = -1;
            bool has_duplicates = false;
            int last_num = -1;

            for (int i = 0; i < n; ++i) {
                if ((mask >> i) & 1) {
                    if (nums[i] == last_num) {
                        has_duplicates = true;
                        break;
                    }
                    if (min_val == -1) {
                        min_val = nums[i];
                    }
                    max_val = nums[i];
                    last_num = nums[i];
                }
            }

            if (!has_duplicates) {
                group_costs[mask] = max_val - min_val;
            }
        }

        std::vector<int> dp(1 << n, -1);
        dp[0] = 0;

        for (int mask = 1; mask < (1 << n); ++mask) {
            if (__builtin_popcount(mask) % group_size != 0) {
                continue;
            }

            for (int submask = mask; submask > 0; submask = (submask - 1) & mask) {
                if (__builtin_popcount(submask) == group_size && group_costs[submask] != -1) {
                    int prev_mask = mask ^ submask;
                    if (dp[prev_mask] != -1) {
                        int current_cost = dp[prev_mask] + group_costs[submask];
                        if (dp[mask] == -1 || current_cost < dp[mask]) {
                            dp[mask] = current_cost;
                        }
                    }
                }
            }
        }

        return dp[(1 << n) - 1];
    }
};