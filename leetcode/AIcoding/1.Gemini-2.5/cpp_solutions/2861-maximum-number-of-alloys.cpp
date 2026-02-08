#include <vector>
#include <algorithm>

class Solution {
public:
    bool can_make(long long num_alloys, int n, int k, long long budget, 
                  const std::vector<std::vector<int>>& composition, 
                  const std::vector<int>& stock, 
                  const std::vector<int>& cost) {

        for (int i = 0; i < k; ++i) { // Iterate through each machine
            long long current_machine_cost = 0;
            bool possible_with_this_machine = true;

            for (int j = 0; j < n; ++j) { // Iterate through each metal
                long long required_metal_j = num_alloys * composition[i][j];

                if (required_metal_j > stock[j]) {
                    long long buy_amount = required_metal_j - stock[j];

                    if (cost[j] == 0) {
                        // No cost to buy this metal, continue
                    } else {
                        // Check if buying this amount of metal 'j' alone would exceed the remaining budget,
                        // or cause overflow if calculated directly.
                        // We need current_machine_cost + (buy_amount * cost[j]) <= budget
                        // Rearranging: (buy_amount * cost[j]) <= budget - current_machine_cost
                        // To avoid overflow of (buy_amount * cost[j]) by checking against budget:
                        // buy_amount <= (budget - current_machine_cost) / cost[j]
                        // If buy_amount > (budget - current_machine_cost) / cost[j], then it's too expensive.

                        // budget - current_machine_cost will always be >= 0 at this point because
                        // current_machine_cost is only incremented if it stays within budget.
                        // If it went over, possible_with_this_machine would have already been set to false.
                        if (buy_amount > (budget - current_machine_cost) / cost[j]) {
                            possible_with_this_machine = false;
                            break; // No need to check other metals for this machine
                        }
                        current_machine_cost += buy_amount * cost[j];
                    }
                }
            }

            if (possible_with_this_machine) {
                return true; // Found a machine that can produce num_alloys within budget
            }
        }
        return false; // No machine can produce num_alloys within budget
    }

    long long maxNumberOfAlloys(int n, int k, long long budget, 
                                const std::vector<std::vector<int>>& composition, 
                                const std::vector<int>& stock, 
                                const std::vector<int>& cost) {

        long long low = 0;
        // A safe upper bound for the number of alloys.
        // Max stock is 10^9, max composition is 1. So 10^9 alloys from stock.
        // Max budget is 10^9, min cost is 1, min composition is 1. So 10^9 alloys from budget.
        // A rough upper bound is 2 * 10^9. Add a small constant for safety.
        long long high = 2000000000LL + 7; 
        long long ans = 0;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            if (can_make(mid, n, k, budget, composition, stock, cost)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans;
    }
};