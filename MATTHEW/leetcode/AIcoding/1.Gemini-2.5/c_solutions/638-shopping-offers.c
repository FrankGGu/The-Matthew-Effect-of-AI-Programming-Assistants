#include <stdlib.h>
#include <string.h> // For memcpy or memset

int* g_price;
int g_needsSize;
int** g_special;
int g_specialSize;

int* memo;

int calculate_key(int* needs) {
    int key = 0;
    int multiplier = 1;
    for (int i = 0; i < g_needsSize; ++i) {
        key += needs[i] * multiplier;
        multiplier *= 11;
    }
    return key;
}

int dfs(int* current_needs) {
    int key = calculate_key(current_needs);

    // If this state has been computed, return the memoized result
    if (memo[key] != -1) {
        return memo[key];
    }

    // Calculate the cost of buying all items in current_needs individually
    int min_cost = 0;
    for (int i = 0; i < g_needsSize; ++i) {
        min_cost += current_needs[i] * g_price[i];
    }

    // Try applying each special offer
    for (int i = 0; i < g_specialSize; ++i) {
        int* offer = g_special[i];
        int offer_price = offer[g_needsSize]; // The last element in an offer is its price

        // Check if the current offer can be applied
        int can_apply = 1;
        for (int j = 0; j < g_needsSize; ++j) {
            if (current_needs[j] < offer[j]) {
                can_apply = 0;
                break;
            }
        }

        if (can_apply) {
            // Apply the offer by reducing the needs
            for (int j = 0; j < g_needsSize; ++j) {
                current_needs[j] -= offer[j];
            }

            // Recursively find the minimum cost for the remaining needs
            int cost_with_offer = offer_price + dfs(current_needs);

            // Update min_cost if this offer path is cheaper
            if (cost_with_offer < min_cost) {
                min_cost = cost_with_offer;
            }

            // Backtrack: restore current_needs for the next offer or parent call
            for (int j = 0; j < g_needsSize; ++j) {
                current_needs[j] += offer[j];
            }
        }
    }

    // Memoize the calculated minimum cost for the current state
    memo[key] = min_cost;
    return min_cost;
}

int shoppingOffers(int* price, int priceSize, int** special, int specialSize, int* specialColSize, int* needs, int needsSize) {
    // Initialize global variables
    g_price = price;
    g_needsSize = needsSize;
    g_special = special;
    g_specialSize = specialSize;

    // Calculate the maximum possible key value for memoization table size
    // Max needs[i] is 10. Using base 11 for encoding.
    // Max key size is 11^needsSize.
    int max_key_size = 1;
    for (int i = 0; i < needsSize; ++i) {
        max_key_size *= 11;
    }

    // Allocate and initialize memoization table
    memo = (int*)malloc(max_key_size * sizeof(int));
    // Initialize all entries to -1, indicating uncomputed states
    for (int i = 0; i < max_key_size; ++i) {
        memo[i] = -1;
    }

    // Create a mutable copy of the initial needs array
    // The dfs function modifies the needs array and then backtracks
    int* initial_needs_copy = (int*)malloc(needsSize * sizeof(int));
    memcpy(initial_needs_copy, needs, needsSize * sizeof(int));

    // Start the depth-first search
    int result = dfs(initial_needs_copy);

    // Free dynamically allocated memory
    free(initial_needs_copy);
    free(memo);

    return result;
}