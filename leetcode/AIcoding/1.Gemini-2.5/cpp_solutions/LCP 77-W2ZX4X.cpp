#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long runeReserve(std::vector<int>& runes) {
        int n = runes.size();
        if (n == 0) {
            return 0;
        }

        // Calculate the total sum of all rune energies.
        long long total_sum = 0;
        for (int rune_energy : runes) {
            total_sum += rune_energy;
        }

        // This problem is a variant of the "House Robber" problem.
        // The phrasing "minimize the total energy sum of selected runes"
        // for positive rune energies (runes[i] >= 1) would trivially be
        // 0 (by selecting no runes) or min(runes[i]) (by selecting one rune).
        // This is usually not the intended solution for a DP problem.
        //
        // A common interpretation for such problems is to minimize the sum
        // of *unselected* items, subject to the constraint on *selected* items.
        // Minimizing `sum(unselected_runes)` is equivalent to maximizing
        // `sum(selected_runes)`, since `sum(unselected_runes) = total_sum - sum(selected_runes)`.
        //
        // So, we will solve for the maximum sum of non-adjacent runes (House Robber),
        // and then subtract this maximum sum from the total sum of all runes.

        // dp_not_picked: maximum sum of non-adjacent runes up to the current index,
        //                where the rune at the current index is NOT picked.
        // dp_picked: maximum sum of non-adjacent runes up to the current index,
        //            where the rune at the current index IS picked.
        long long dp_not_picked = 0;
        long long dp_picked = runes[0];

        for (int i = 1; i < n; ++i) {
            // If current rune is not picked, the max sum is the max sum from the previous state
            // (either previous rune was picked or not picked).
            long long current_not_picked = std::max(dp_not_picked, dp_picked);

            // If current rune is picked, the max sum is current rune's energy plus
            // the max sum from the state where the previous rune was NOT picked (since adjacent cannot be picked).
            long long current_picked = runes[i] + dp_not_picked;

            // Update for the next iteration
            dp_not_picked = current_not_picked;
            dp_picked = current_picked;
        }

        // The maximum sum of non-adjacent runes is the maximum of the two final states.
        long long max_picked_sum = std::max(dp_not_picked, dp_picked);

        // The result is total_sum - max_picked_sum (minimum sum of unpicked runes).
        return total_sum - max_picked_sum;
    }
};