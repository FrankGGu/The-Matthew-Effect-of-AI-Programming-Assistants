#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long minimumDamage(const std::vector<int>& nums, const std::vector<int>& cost, int x) {
        // This solution assumes the problem is a variation of the unbounded knapsack problem:
        // 'nums[i]' represents a type of damage that can be dealt.
        // 'cost[i]' is the cost to deal 'nums[i]' damage.
        // 'x' is the target total damage to deal to Bob.
        // We want to find the minimum total cost to deal exactly 'x' damage.
        // Each type of damage (nums[i]) can be dealt multiple times.

        // dp[j] will store the minimum cost to achieve exactly 'j' damage.
        // Initialize with -1 to indicate an unreachable state, except dp[0] which is 0.
        std::vector<long long> dp(x + 1, -1);
        dp[0] = 0; // 0 damage costs 0

        // Iterate through each available damage type
        for (int i = 0; i < nums.size(); ++i) {
            int current_damage_value = nums[i];
            int current_cost_value = cost[i];

            // Iterate through possible total damage amounts from current_damage_value up to x
            // This order ensures that each damage type can be used multiple times (unbounded knapsack)
            for (int j = current_damage_value; j <= x; ++j) {
                // If the state (j - current_damage_value) is reachable
                if (dp[j - current_damage_value] != -1) {
                    long long new_cost = dp[j - current_damage_value] + current_cost_value;
                    // If current state 'j' is unreachable or we found a cheaper way
                    if (dp[j] == -1 || new_cost < dp[j]) {
                        dp[j] = new_cost;
                    }
                }
            }
        }

        return dp[x];
    }
};