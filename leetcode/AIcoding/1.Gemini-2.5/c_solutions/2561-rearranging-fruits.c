```c++
#include <vector>
#include <map>
#include <algorithm>
#include <limits>

class Solution {
public:
    long long minCost(std::vector<int>& basket1, std::vector<int>& basket2) {
        std::map<int, int> b1_counts;
        std::map<int, int> b2_counts;
        std::map<int, int> total_counts;
        int min_val = std::numeric_limits<int>::max();

        for (int fruit : basket1) {
            b1_counts[fruit]++;
            total_counts[fruit]++;
            min_val = std::min(min_val, fruit);
        }
        for (int fruit : basket2) {
            b2_counts[fruit]++;
            total_counts[fruit]++;
            min_val = std::min(min_val, fruit);
        }

        std::vector<int> fruits_from_b1_to_swap;
        std::vector<int> fruits_from_b2_to_swap;

        for (auto const& [fruit_val, total_count] : total_counts) {
            if (total_count % 2 != 0) {
                return -1;
            }
            int target_count = total_count / 2;
            int current_b1_count = b1_counts[fruit_val];
            int current_b2_count = b2_counts[fruit_val];

            for (int i = 0; i < current_b1_count - target_count; ++i) {
                fruits_from_b1_to_swap.push_back(fruit_val);
            }
            for (int i = 0; i < current_b2_count - target_count; ++i) {
                fruits_from_b2_to_swap.push_back(fruit_val);
            }
        }

        std::sort(fruits_from_b1_to_swap.begin(), fruits_from_b1_to_swap.end());
        std::sort(fruits_from_b2_to_swap.begin(), fruits_from_b2_to_swap.end());

        long long total_cost = 0;
        int k = fruits_from_b1_to_swap.size();

        for (int i = 0; i < k; ++i) {
            long long direct_swap_cost = std::min((long long)fruits_from_b1_to_swap[i], (long long)fruits_from_b2_to_swap[k - 1 - i]);
            long long indirect_swap_cost = 2LL * min_val;
            total_cost += std::min(direct_swap_cost, indirect_swap_cost);
        }

        return total_cost;
    }
};