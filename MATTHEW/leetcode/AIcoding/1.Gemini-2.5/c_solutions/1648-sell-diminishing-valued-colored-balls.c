#include <stdlib.h> // For qsort

int compare(const void *a, const void *b) {
    return *(int*)b - *(int*)a;
}

long long maxProfit(int* inventory, int inventorySize, int orders) {
    qsort(inventory, inventorySize, sizeof(int), compare);

    long long total_value = 0;
    long long current_orders = (long long)orders; // Use long long for orders
    long long MOD = 1000000007;

    long long current_idx = 0;
    long long num_colors_at_this_level = 0; // Number of colors currently having inventory[current_idx] as their highest value

    while (current_orders > 0 && current_idx < inventorySize) {
        num_colors_at_this_level++; // This color (inventory[current_idx]) is now part of the highest value group

        long long current_val = inventory[current_idx];
        long long next_val = 0;
        if (current_idx + 1 < inventorySize) {
            next_val = inventory[current_idx + 1];
        }

        long long diff = current_val - next_val;

        // If diff is 0, it means current_val == next_val.
        // We just increment num_colors_at_this_level and move to the next inventory element.
        // No balls are sold in this 'level' if diff is 0, as there's no value drop.
        if (diff == 0) {
            current_idx++;
            continue;
        }

        // Calculate the total number of balls we can sell from 'current_val' down to 'next_val + 1'
        // for all 'num_colors_at_this_level' colors.
        // Each of these 'num_colors_at_this_level' colors contributes 'diff' balls.
        long long balls_to_sell_this_step = diff * num_colors_at_this_level;

        if (balls_to_sell_this_step <= current_orders) {
            // We have enough orders to sell all 'diff' balls from each of the
            // 'num_colors_at_this_level' colors (i.e., from current_val down to next_val + 1).

            // Sum of an arithmetic series: current_val + (current_val - 1) + ... + (next_val + 1)
            // Number of terms (n) = diff
            // First term (a) = current_val
            // Sum = n * (2a - n + 1) / 2
            long long sum_for_one_color = (long long)diff * (2LL * current_val - diff + 1) / 2;

            // Add the value for all colors at this level, applying modulo at each multiplication
            total_value = (total_value + (sum_for_one_color % MOD * num_colors_at_this_level % MOD)) % MOD;
            current_orders -= balls_to_sell_this_step;
            current_idx++; // Move to process the next distinct inventory value
        } else {
            // We don't have enough orders to sell all 'balls_to_sell_this_step'.
            // We will sell only 'current_orders' balls from these 'num_colors_at_this_level' colors.

            long long num_full_levels = current_orders / num_colors_at_this_level;
            long long remaining_balls = current_orders % num_colors_at_this_level;

            // Sell 'num_full_levels' balls from each of the 'num_colors_at_this_level' colors.
            // These balls will have values from 'current_val' down to 'current_val - num_full_levels + 1'.
            if (num_full_levels > 0) {
                long long first_val = current_val;
                // Sum = n * (2a - n + 1) / 2 where n = num_full_levels, a = first_val
                long long sum_for_one_color = (long long)num_full_levels * (2LL * first_val - num_full_levels + 1) / 2;
                total_value = (total_value + (sum_for_one_color % MOD * num_colors_at_this_level % MOD)) % MOD;
            }

            // After selling 'num_full_levels' balls from each color, the next highest value is
            // 'current_val - num_full_levels'.
            // Sell the 'remaining_balls', each with this value.
            long long final_val_for_remaining = current_val - num_full_levels;
            total_value = (total_value + (remaining_balls * final_val_for_remaining % MOD)) % MOD;

            current_orders = 0; // All orders fulfilled, terminate loop
        }
    }

    return total_value;
}