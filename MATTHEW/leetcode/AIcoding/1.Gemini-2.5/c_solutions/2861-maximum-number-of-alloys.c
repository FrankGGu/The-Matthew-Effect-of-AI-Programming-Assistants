#include <stdbool.h>
#include <stdlib.h>
#include <limits.h> // For LLONG_MAX

bool can_make(long long num_alloys, int n, int k, long long budget, int** composition, int* stock, int* cost) {
    for (int i = 0; i < k; ++i) { // Iterate through each factory
        long long current_factory_cost = 0;
        for (int j = 0; j < n; ++j) { // Iterate through each metal type
            // Calculate required amount of metal j for num_alloys using factory i
            // num_alloys can be up to 2*10^9, composition[i][j] up to 10^9.
            // Their product can be up to 2*10^18, so must use long long.
            long long required_metal_j = num_alloys * composition[i][j];

            if (required_metal_j > stock[j]) {
                long long to_buy = required_metal_j - stock[j];

                // If cost[j] is 0, buying is free.
                if (cost[j] == 0) {
                    // No cost for this metal, continue
                } else {
                    // Check for potential overflow of to_buy * cost[j]
                    // LLONG_MAX is approximately 9 * 10^18.
                    // If to_buy is 2 * 10^18 and cost[j] is 10^9, their product (2 * 10^27) would overflow long long.
                    // If to_buy * cost[j] would overflow, it definitely exceeds the budget (10^9).
                    if (to_buy > LLONG_MAX / cost[j]) {
                        current_factory_cost = budget + 1; // Mark as exceeding budget
                        break; // No need to check further metals for this factory
                    }

                    long long metal_cost = to_buy * cost[j];

                    // Check if adding this metal_cost would exceed the budget
                    // This is equivalent to current_factory_cost + metal_cost > budget
                    // This check prevents current_factory_cost from overflowing if budget is small
                    // and metal_cost is large (but still fits in long long).
                    if (current_factory_cost > budget - metal_cost) {
                        current_factory_cost = budget + 1; // Mark as exceeding budget
                        break; // No need to check further metals for this factory
                    }
                    current_factory_cost += metal_cost;
                }
            }
        }
        if (current_factory_cost <= budget) {
            return true; // This factory can make num_alloys within budget
        }
    }
    return false; // No factory can make num_alloys within budget
}

long long maxNumberOfAlloys(int n, int k, long long budget, int** composition, int compositionSize, int* compositionColSize, int* stock, int stockSize, int* cost, int costSize) {
    long long low = 0;
    // A safe upper bound for the number of alloys.
    // Max stock is 10^9, max budget is 10^9. If composition is 1 and cost is 1,
    // we could potentially make 10^9 (from stock) + 10^9 (from budget) = 2 * 10^9 alloys.
    long long high = 2000000000 + 7; 
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