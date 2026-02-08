#include <stdlib.h> // Required for NULL, though not strictly used in the logic itself
#include <limits.h> // Required for INT_MAX if we were initializing with a very large number, but not directly used here.

static inline int min(int a, int b) {
    return (a < b) ? a : b;
}

int minCost(int** costs, int costsSize, int* costsColSize) {
    if (costsSize == 0) {
        return 0;
    }

    // Initialize previous costs with the costs of painting the first house
    // prev_cost_0: minimum cost to paint house (i-1) with color 0
    // prev_cost_1: minimum cost to paint house (i-1) with color 1
    // prev_cost_2: minimum cost to paint house (i-1) with color 2
    int prev_cost_0 = costs[0][0];
    int prev_cost_1 = costs[0][1];
    int prev_cost_2 = costs[0][2];

    // Iterate from the second house (index 1) up to the last house
    for (int i = 1; i < costsSize; i++) {
        // Calculate current costs for house 'i'
        // curr_cost_0: minimum cost to paint house 'i' with color 0
        // To paint house 'i' with color 0, house (i-1) must be painted with color 1 or 2.
        int curr_cost_0 = costs[i][0] + min(prev_cost_1, prev_cost_2);

        // curr_cost_1: minimum cost to paint house 'i' with color 1
        // To paint house 'i' with color 1, house (i-1) must be painted with color 0 or 2.
        int curr_cost_1 = costs[i][1] + min(prev_cost_0, prev_cost_2);

        // curr_cost_2: minimum cost to paint house 'i' with color 2
        // To paint house 'i' with color 2, house (i-1) must be painted with color 0 or 1.
        int curr_cost_2 = costs[i][2] + min(prev_cost_0, prev_cost_1);

        // Update previous costs for the next iteration
        prev_cost_0 = curr_cost_0;
        prev_cost_1 = curr_cost_1;
        prev_cost_2 = curr_cost_2;
    }

    // After iterating through all houses, the minimum cost to paint all houses
    // is the minimum of the costs of painting the last house with any of the three colors.
    return min(prev_cost_0, min(prev_cost_1, prev_cost_2));
}