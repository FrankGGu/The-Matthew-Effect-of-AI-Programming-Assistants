#include <vector>
#include <map>
#include <algorithm>
#include <climits> // For LLONG_MAX

class Solution {
public:
    long long minCost(std::vector<int>& basket1, std::vector<int>& basket2) {
        std::map<int, int> freq_b1, freq_b2, freq_all;

        for (int fruit : basket1) {
            freq_b1[fruit]++;
            freq_all[fruit]++;
        }
        for (int fruit : basket2) {
            freq_b2[fruit]++;
            freq_all[fruit]++;
        }

        long long min_val = LLONG_MAX;
        for (auto const& [fruit, count] : freq_all) {
            if (count % 2 != 0) {
                return -1; // Impossible to make baskets identical if any fruit has an odd total count
            }
            min_val = std::min(min_val, (long long)fruit);
        }

        std::vector<int> to_swap;
        for (auto const& [fruit, total_count] : freq_all) {
            int target_count = total_count / 2;
            int b1_count = freq_b1[fruit];
            // int b2_count = freq_b2[fruit]; // Not strictly needed for calculation, but good for understanding

            // If basket1 has more of this fruit than the target, these are "excess" fruits in basket1
            // They need to be swapped out.
            for (int i = 0; i < b1_count - target_count; ++i) {
                to_swap.push_back(fruit);
            }

            // Note: We only need to collect excess fruits from one basket.
            // The number of fruits in excess in basket1 (compared to target_count)
            // will be exactly equal to the number of fruits in deficit in basket2 (compared to target_count),
            // plus the number of fruits in excess in basket2.
            // A simpler way to think: for each fruit type, if a basket has more than target_count,
            // those are the fruits that need to move. The sum of these counts across both baskets
            // for all fruit types will be an even number, say 2K. We need K swaps.
            // The current loop structure correctly collects all fruits that are in excess in either basket.
            // Example: if b1 has 3 of fruit X, target is 2. Add X to to_swap.
            // if b2 has 3 of fruit Y, target is 2. Add Y to to_swap.
            // The `to_swap` vector will contain all fruits that are "out of place" in their current basket.
        }

        std::sort(to_swap.begin(), to_swap.end());

        long long total_cost = 0;
        // We need to perform to_swap.size() / 2 swaps.
        // To minimize cost, we pair the smallest fruits that need to move
        // with the largest fruits that need to move.
        // For each fruit 'x' in the first half of `to_swap` (smallest 'x's),
        // we can either swap it directly with a corresponding fruit 'y' from the second half (largest 'y's).
        // The cost of such a direct swap (x, y) is min(x, y). Since x <= y, this is x.
        // OR, we can use the globally smallest fruit 'min_val' as an intermediary.
        // This involves two swaps: x <-> min_val, then y <-> min_val.
        // The total cost for this pair (x, y) using min_val as intermediary is 2 * min_val.
        // So, for each of the smallest 'x' fruits, the cost incurred is min(x, 2 * min_val).
        for (size_t i = 0; i < to_swap.size() / 2; ++i) {
            total_cost += std::min((long long)to_swap[i], 2 * min_val);
        }

        return total_cost;
    }
};