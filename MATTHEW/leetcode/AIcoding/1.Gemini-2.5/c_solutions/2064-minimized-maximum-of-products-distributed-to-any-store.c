#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int check(long long max_val, int n, int* quantities, int quantitiesSize) {
    long long stores_needed = 0;
    for (int i = 0; i < quantitiesSize; i++) {
        // Calculate the number of "slots" (portions of products) required for quantities[i] items.
        // (quantities[i] + max_val - 1) / max_val is an integer division equivalent to ceil(quantities[i] / max_val).
        stores_needed += (quantities[i] + max_val - 1) / max_val;

        // Optimization: If the number of stores needed already exceeds 'n',
        // then this 'max_val' is not feasible, no need to continue summing.
        if (stores_needed > n) {
            return 0; // Not feasible
        }
    }
    // If all product types can be distributed using 'n' or fewer stores, then 'max_val' is feasible.
    return 1; // Feasible
}

int minimizedMaximum(int n, int* quantities, int quantitiesSize) {
    long long low = 1; // The minimum possible value for the maximum products in any store is 1.
    long long high = 0; // This will store the maximum quantity from the input array.

    // Find the maximum quantity in the 'quantities' array.
    // This maximum quantity serves as the upper bound for our binary search.
    // The answer cannot be greater than the largest individual quantity,
    // because if 'n' is large enough, each product type can go to its own store,
    // and the maximum would be the largest quantity.
    for (int i = 0; i < quantitiesSize; i++) {
        if (quantities[i] > high) {
            high = quantities[i];
        }
    }

    long long ans = high; // Initialize 'ans' with a valid upper bound (e.g., the maximum quantity).

    // Perform binary search to find the minimized maximum.
    // We are searching for the smallest 'mid' value that satisfies the 'check' condition.
    while (low <= high) {
        long long mid = low + (high - low) / 2; // Calculate the middle value

        // Check if 'mid' is a feasible maximum.
        if (check(mid, n, quantities, quantitiesSize)) {
            ans = mid; // 'mid' is feasible, so it's a potential answer. Try to find a smaller one.
            high = mid - 1;
        } else {
            // 'mid' is not feasible, meaning we need to allow more products per store.
            // Increase 'low' to search in the upper half.
            low = mid + 1;
        }
    }

    // The final 'ans' will be the smallest feasible maximum.
    return (int)ans;
}