#include <math.h> // Required for sqrt, though not directly used in the final optimized check
#include <stdbool.h> // For bool type

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long maximumSum(int* nums, int numsSize) {
    long long max_sum = 0;
    int n = numsSize;

    // Iterate through all possible square-free parts 'k'
    // An index 'i' belongs to a complete subset if its square-free part is 'k'.
    // Indices in such a subset are of the form k * m^2.
    for (int k = 1; k <= n; ++k) {
        // Check if 'k' is square-free
        // A number is square-free if it is not divisible by any perfect square greater than 1.
        // We iterate through potential square factors (p*p).
        bool is_square_free = true;
        for (long long p = 2; p * p <= k; ++p) { // Use long long for p*p to prevent overflow
            if (k % (p * p) == 0) {
                is_square_free = false;
                break;
            }
        }

        if (!is_square_free) {
            continue; // If k is not square-free, it's not a unique square-free part for any index.
                      // Any index of the form (non-square-free k) * m^2 can be rewritten as
                      // (square-free part of k) * (some_other_integer)^2, and will be handled
                      // when the outer loop variable is the actual square-free part.
        }

        long long current_subset_sum = 0;
        // Iterate through multiples of k that are perfect squares (k * m^2)
        // These are all indices whose square-free part is 'k'.
        for (long long m = 1; ; ++m) {
            long long current_index_1_based = (long long)k * m * m; // Calculate 1-based index

            if (current_index_1_based > n) {
                break; // Index out of bounds (1 to n)
            }

            // Add the corresponding element from nums (0-based array)
            current_subset_sum += nums[(int)current_index_1_based - 1];
        }

        // Update the maximum sum found so far
        max_sum = max(max_sum, current_subset_sum);
    }

    return max_sum;
}