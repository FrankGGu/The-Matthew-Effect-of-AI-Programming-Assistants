#include <vector>
#include <map>

class Solution {
public:
    int inventoryManagement(std::vector<int>& stock, long long k) {
        long long total_value = 0;
        long long MOD = 1e9 + 7;

        // Use std::map to store frequencies. Keys are item values, values are their counts.
        // std::map stores keys in ascending order, so rbegin() gives the largest value.
        std::map<int, long long> freq;
        for (int s : stock) {
            freq[s]++;
        }

        // Modular inverse of 2 for division in arithmetic series sum.
        // (A * B / 2) % M = (A * B * 2^-1) % M
        // For M = 1e9 + 7 (a prime number), 2^-1 mod M is (M + 1) / 2.
        long long inv2 = 500000004; 

        while (k > 0 && !freq.empty()) {
            auto it = freq.rbegin(); // Iterator to the largest value
            int current_val = it->first;
            long long current_count = it->second;

            // If current_val is 0, we can't sell anything more from this value.
            // All remaining items must have value 0 or less.
            if (current_val == 0) {
                break; 
            }

            // Find the next largest distinct value smaller than current_val.
            // If current_val is the smallest distinct value in the map, or if there are no other positive values,
            // then next_val_down is effectively 0 (meaning we sell down to 1).
            int next_val_down = 0;
            if (std::next(it) != freq.rend()) { 
                next_val_down = std::next(it)->first;
            }

            // The number of distinct value levels we can process downwards from current_val
            // until next_val_down (exclusive of next_val_down).
            // E.g., if current_val=5, next_val_down=2, we can process values 5, 4, 3. num_steps = 3.
            long long num_steps = current_val - next_val_down;

            // Calculate the total number of items we would sell if we processed all `current_count` items
            // down through `num_steps` value levels.
            long long total_items_to_sell_in_block = current_count * num_steps;

            // Case 1: We have enough 'k' to sell all `current_count` items `num_steps` times.
            // This means we sell `current_count * num_steps` items in total.
            if (k >= total_items_to_sell_in_block) {
                // We sell all `current_count` items, each decreasing in value from `current_val`
                // down to `next_val_down + 1`.
                // The values sold for one item form an arithmetic series:
                // current_val, current_val-1, ..., next_val_down+1
                // Sum of this series = (first_term + last_term) * number_of_terms / 2
                long long first_val_in_series = current_val;
                long long last_val_in_series = next_val_down + 1;

                // Calculate sum for one item over num_steps, applying modulo at each step.
                long long sum_for_one_item = ((first_val_in_series % MOD + last_val_in_series % MOD) % MOD * (num_steps % MOD)) % MOD;
                sum_for_one_item = (sum_for_one_item * inv2) % MOD;

                // Add the value from selling all `current_count` items this way.
                total_value = (total_value + current_count % MOD * sum_for_one_item) % MOD;

                // Decrease k by the number of items sold.
                k -= total_items_to_sell_in_block;

                // After these sales, `current_count` items now have value `next_val_down`.
                // Merge them into `freq[next_val_down]`.
                if (next_val_down > 0) { // Only merge if the target value is still positive
                    freq[next_val_down] += current_count;
                }
                freq.erase(current_val); // Remove the old entry for current_val
            }
            // Case 2: We cannot sell all `current_count` items `num_steps` times.
            // This means `k < current_count * num_steps`. We will sell items until `k` becomes 0.
            else {
                // Determine how many full rounds of selling all `current_count` items we can do.
                long long num_full_rounds = k / current_count;
                // Determine how many items are left to sell after full rounds (these will be sold once).
                long long remaining_items_to_sell = k % current_count;

                // Process the `num_full_rounds`.
                // These `current_count` items are sold `num_full_rounds` times.
                // Values sold for one item: current_val, current_val-1, ..., current_val - num_full_rounds + 1.
                long long first_val_in_round = current_val;
                long long last_val_in_round = current_val - num_full_rounds + 1;

                // Calculate sum for one item over num_full_rounds, applying modulo.
                long long sum_for_one_item_full_rounds = ((first_val_in_round % MOD + last_val_in_round % MOD) % MOD * (num_full_rounds % MOD)) % MOD;
                sum_for_one_item_full_rounds = (sum_for_one_item_full_rounds * inv2) % MOD;

                // Add the value from these full rounds.
                total_value = (total_value + current_count % MOD * sum_for_one_item_full_rounds) % MOD;

                // Process the `remaining_items_to_sell`.
                // These items are sold at the value just below the last value from full rounds.
                long long val_for_remaining = last_val_in_round - 1;

                // Only add value if it's positive.
                if (val_for_remaining > 0) { 
                    total_value = (total_value + remaining_items_to_sell % MOD * (val_for_remaining % MOD)) % MOD;
                }

                k = 0; // All k items are sold.
            }
        }

        return static_cast<int>(total_value);
    }
};