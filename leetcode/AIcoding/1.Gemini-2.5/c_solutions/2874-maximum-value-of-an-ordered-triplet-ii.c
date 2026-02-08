#include <stdlib.h> // For malloc, free
#include <limits.h> // For LLONG_MIN (though not strictly used, 0LL is sufficient)

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

long long maximumTripletValue(int* nums, int numsSize) {
    // Problem constraints state numsSize >= 3, so this check is technically not needed
    // but good practice for robustness.
    if (numsSize < 3) {
        return 0LL;
    }

    // Allocate memory for prefix and suffix arrays
    long long* max_prefix = (long long*)malloc(numsSize * sizeof(long long));
    long long* max_suffix = (long long*)malloc(numsSize * sizeof(long long));
    long long* min_suffix = (long long*)malloc(numsSize * sizeof(long long));

    // Calculate max_prefix: max_prefix[p] stores max(nums[0]...nums[p])
    max_prefix[0] = nums[0];
    for (int p = 1; p < numsSize; p++) {
        max_prefix[p] = MAX(max_prefix[p - 1], nums[p]);
    }

    // Calculate max_suffix and min_suffix:
    // max_suffix[p] stores max(nums[p]...nums[numsSize-1])
    // min_suffix[p] stores min(nums[p]...nums[numsSize-1])
    max_suffix[numsSize - 1] = nums[numsSize - 1];
    min_suffix[numsSize - 1] = nums[numsSize - 1];
    for (int p = numsSize - 2; p >= 0; p--) {
        max_suffix[p] = MAX(max_suffix[p + 1], nums[p]);
        min_suffix[p] = MIN(min_suffix[p + 1], nums[p]);
    }

    long long max_triplet_value = 0LL; // Initialize to 0 as per problem statement

    // Iterate through 'j' as the middle element of the triplet (nums[i] - nums[j]) * nums[k]
    // 'j' can range from 1 to numsSize - 2 (inclusive)
    for (int j = 1; j < numsSize - 1; j++) {
        // For a fixed 'j', 'i' must be less than 'j'.
        // To maximize (nums[i] - nums[j]), we need the maximum nums[i] for i < j.
        // This is max_prefix[j-1], which stores max(nums[0]...nums[j-1]).
        long long max_i_val = max_prefix[j - 1];

        // For a fixed 'j', 'k' must be greater than 'j'.
        // We need to consider both the largest possible nums[k] (val_k_pos)
        // and the smallest possible nums[k] (val_k_neg) because (max_i_val - nums[j])
        // can be positive or negative, affecting which nums[k] yields the maximum product.
        // val_k_pos stores max(nums[j+1]...nums[numsSize-1]).
        long long val_k_pos = max_suffix[j + 1];

        // val_k_neg stores min(nums[j+1]...nums[numsSize-1]).
        long long val_k_neg = min_suffix[j + 1];

        long long term_ij = max_i_val - nums[j];

        // Calculate product with the largest possible nums[k]
        // This is optimal if term_ij >= 0.
        long long current_product1 = term_ij * val_k_pos;

        // Calculate product with the smallest possible nums[k]
        // This is optimal if term_ij < 0 (to make the product positive).
        long long current_product2 = term_ij * val_k_neg;

        // Update the overall maximum triplet value
        max_triplet_value = MAX(max_triplet_value, current_product1);
        max_triplet_value = MAX(max_triplet_value, current_product2);
    }

    // Free allocated memory
    free(max_prefix);
    free(max_suffix);
    free(min_suffix);

    return max_triplet_value;
}