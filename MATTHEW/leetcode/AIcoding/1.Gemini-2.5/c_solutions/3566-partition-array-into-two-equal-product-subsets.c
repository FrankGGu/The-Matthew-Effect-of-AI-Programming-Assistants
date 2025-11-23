#include <stdbool.h>
#include <limits.h> // For LLONG_MAX, LLONG_MIN
#include <stdlib.h> // For malloc, free

typedef struct {
    long long val;
    bool overflow;
} ProductState;

ProductState multiply(ProductState ps, int num) {
    if (ps.overflow) {
        return ps; // If already overflowed, it stays overflowed
    }

    if (num == 0) {
        ps.val = 0;
        ps.overflow = false; // Product becomes 0, no overflow
        return ps;
    }

    // Check for potential overflow before multiplication
    // This logic covers all cases for non-zero `num`
    if (ps.val > 0) {
        if (num > 0) { // Positive * Positive: check against LLONG_MAX
            if (ps.val > LLONG_MAX / num) {
                ps.overflow = true;
            }
        } else { // Positive * Negative: result will be negative, check against LLONG_MIN
            // Equivalent to checking if ps.val * num < LLONG_MIN
            // Since num is negative, dividing by num flips the inequality: ps.val > LLONG_MIN / num
            if (ps.val > LLONG_MIN / num) { // LLONG_MIN / num is positive or 0
                ps.overflow = true;
            }
        }
    } else { // ps.val < 0 (ps.val == 0 is handled by num == 0 case)
        if (num > 0) { // Negative * Positive: result will be negative, check against LLONG_MIN
            // Equivalent to checking if ps.val * num < LLONG_MIN
            // Since num is positive, dividing by num preserves the inequality: ps.val < LLONG_MIN / num
            if (ps.val < LLONG_MIN / num) { // LLONG_MIN / num is negative or 0
                ps.overflow = true;
            }
        } else { // Negative * Negative: result will be positive, check against LLONG_MAX
            // Equivalent to checking if ps.val * num > LLONG_MAX
            // Since num is negative, dividing by num flips the inequality: ps.val < LLONG_MAX / num
            if (ps.val < LLONG_MAX / num) { // LLONG_MAX / num is negative or 0
                ps.overflow = true;
            }
        }
    }

    if (!ps.overflow) {
        ps.val *= num;
    }
    return ps;
}

bool canPartitionArrayIntoTwoEqualProductSubsets(int* nums, int numsSize) {
    if (numsSize < 2) {
        return false; // Cannot partition into two non-empty subarrays
    }

    // Allocate memory for prefix and suffix product states
    ProductState* prefix_products = (ProductState*)malloc(numsSize * sizeof(ProductState));
    ProductState* suffix_products = (ProductState*)malloc(numsSize * sizeof(ProductState));

    // Handle allocation failure (though LeetCode usually guarantees it won't fail for typical constraints)
    if (!prefix_products || !suffix_products) {
        free(prefix_products); // Free any partially allocated memory
        free(suffix_products);
        return false; 
    }

    // Calculate prefix products
    prefix_products[0] = (ProductState){.val = nums[0], .overflow = false};
    for (int i = 1; i < numsSize; ++i) {
        prefix_products[i] = multiply(prefix_products[i-1], nums[i]);
    }

    // Calculate suffix products
    suffix_products[numsSize - 1] = (ProductState){.val = nums[numsSize - 1], .overflow = false};
    for (int i = numsSize - 2; i >= 0; --i) {
        suffix_products[i] = multiply(suffix_products[i+1], nums[i]);
    }

    // Check for a split point
    // Iterate through all possible split points 'i' (0 to numsSize - 2)
    // where the left subarray is nums[0...i] and the right is nums[i+1...numsSize-1]
    for (int i = 0; i < numsSize - 1; ++i) {
        // Compare prefix_products[i] with suffix_products[i+1]
        if (prefix_products[i].val == suffix_products[i+1].val &&
            prefix_products[i].overflow == suffix_products[i+1].overflow) {
            free(prefix_products);
            free(suffix_products);
            return true;
        }
    }

    free(prefix_products);
    free(suffix_products);
    return false;
}