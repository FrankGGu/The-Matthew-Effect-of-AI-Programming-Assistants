#include <stdbool.h>
#include <stdlib.h>
#include <string.h> // For memcpy, memset, qsort

int compareInt(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int compareIntDesc(const void* a, const void* b) {
    return (*(int*)b - *(int*)a);
}

int* g_counts; // Stores frequencies of distinct numbers
int g_n_distinct; // Number of distinct distinct numbers
int* g_quantity; // Customer demands
int g_m; // Number of customers

bool backtrack(int customer_idx) {
    if (customer_idx == g_m) {
        return true; // All customers satisfied
    }

    // Iterate through available distinct item types
    for (int i = 0; i < g_n_distinct; ++i) {
        // If current item type has enough quantity for the current customer
        if (g_counts[i] >= g_quantity[customer_idx]) {
            g_counts[i] -= g_quantity[customer_idx]; // Assign items
            if (backtrack(customer_idx + 1)) { // Recurse for the next customer
                return true; // If successful, propagate true
            }
            g_counts[i] += g_quantity[customer_idx]; // Backtrack: restore count for other possibilities
        }
    }
    return false; // No way to satisfy current customer with remaining items
}

bool canDistribute(int* nums, int numsSize, int* quantity, int quantitySize) {
    // 1. Count frequencies of numbers in nums
    // nums[i] values are up to 1000, so use an array for frequency counting.
    int freq[1001] = {0}; // Max value of nums[i] is 1000
    for (int i = 0; i < numsSize; ++i) {
        freq[nums[i]]++;
    }

    // Populate g_counts with non-zero frequencies
    // The maximum number of distinct elements is numsSize.
    int temp_counts_buffer[numsSize]; 
    g_n_distinct = 0;
    for (int i = 1; i <= 1000; ++i) { // Iterate through possible number values
        if (freq[i] > 0) {
            temp_counts_buffer[g_n_distinct++] = freq[i];
        }
    }

    // Allocate memory for g_counts and copy.
    // This is necessary because g_counts is modified during recursion.
    g_counts = (int*)malloc(g_n_distinct * sizeof(int));
    if (g_counts == NULL) {
        return false; // Handle allocation failure
    }
    memcpy(g_counts, temp_counts_buffer, g_n_distinct * sizeof(int));

    // 2. Sort g_counts in descending order.
    // This is a common heuristic for pruning in subset-sum/bin-packing type problems.
    // Trying to use up larger quantities first can lead to faster pruning.
    qsort(g_counts, g_n_distinct, sizeof(int), compareIntDesc);

    // 3. Sort quantity in descending order.
    // This is crucial for pruning the search space faster. Satisfying larger demands first
    // tends to fail earlier if impossible, or find a solution faster.
    qsort(quantity, quantitySize, sizeof(int), compareIntDesc);

    g_quantity = quantity;
    g_m = quantitySize;

    bool result = backtrack(0);

    // Clean up allocated memory
    free(g_counts);

    return result;
}