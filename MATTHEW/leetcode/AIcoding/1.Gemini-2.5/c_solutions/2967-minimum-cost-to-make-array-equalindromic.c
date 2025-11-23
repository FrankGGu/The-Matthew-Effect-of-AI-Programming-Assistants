#include <stdlib.h> // For qsort, abs
#include <math.h>   // For llabs (long long abs)
#include <stdbool.h> // For bool

long long palindromes[60000]; 
int pal_count = 0;

int compareLongLong(const void *a, const void *b) {
    long long val_a = *(long long*)a;
    long long val_b = *(long long*)b;
    if (val_a < val_b) return -1;
    if (val_a > val_b) return 1;
    return 0;
}

int compareInt(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

long long build_palindrome(long long half, bool is_odd) {
    long long res = half;
    if (is_odd) {
        half /= 10; // Remove the last digit of `half` to form the second half (e.g., 123 -> 12)
    }

    while (half > 0) {
        // Check for potential overflow before multiplying by 10
        // Max palindrome is 999,999,999. If res * 10 exceeds this, it's too large.
        if (res > 1000000000LL / 10) { 
            return 2000000000LL; // Return a value guaranteed to be > 10^9
        }
        res = res * 10 + (half % 10);
        half /= 10;
    }
    return res;
}

void generate_palindromes_optimized() {
    // Iterate through numbers that can form the first half of a palindrome
    // `i` up to 100000 covers all 9-digit odd palindromes (e.g., 99999 -> 999999999)
    for (long long i = 1; i <= 100000; ++i) { 
        // Generate odd length palindromes (e.g., i=123 -> 12321)
        long long p_odd = build_palindrome(i, true);
        if (p_odd <= 1000000000LL) {
            palindromes[pal_count++] = p_odd;
        }

        // Generate even length palindromes (e.g., i=123 -> 123321)
        // For even length palindromes, if `i` has more than 4 digits, 
        // the resulting palindrome will exceed 10^9.
        // (e.g., i=10000 (5 digits) -> 1000000001 (10 digits))
        if (i <= 9999) { // Max 4 digits for `i` to form an 8-digit even palindrome
            long long p_even = build_palindrome(i, false);
            if (p_even <= 1000000000LL) {
                palindromes[pal_count++] = p_even;
            }
        }
    }

    // Sort the generated palindromes
    qsort(palindromes, pal_count, sizeof(long long), compareLongLong);

    // Remove duplicates (e.g., single digit palindromes are generated multiple times)
    int unique_count = 0;
    if (pal_count > 0) {
        palindromes[unique_count++] = palindromes[0];
        for (int k = 1; k < pal_count; ++k) {
            if (palindromes[k] != palindromes[k-1]) {
                palindromes[unique_count++] = palindromes[k];
            }
        }
    }
    pal_count = unique_count;
}

long long calculate_cost(int* nums, int numsSize, long long target) {
    long long current_cost = 0;
    for (int i = 0; i < numsSize; ++i) {
        current_cost += llabs((long long)nums[i] - target);
    }
    return current_cost;
}

long long minCost(int* nums, int numsSize) {
    // Use a static flag to ensure palindromes are generated only once
    static bool generated = false;
    if (!generated) {
        generate_palindromes_optimized();
        generated = true;
    }

    // Sort the input array `nums` to find its median
    qsort(nums, numsSize, sizeof(int), compareInt);

    // The median of `nums` is the unconstrained optimal target for sum(|x_i - p|)
    long long median = nums[numsSize / 2];

    long long min_total_cost = -1; // Initialize with a sentinel value to indicate no cost calculated yet

    // Use binary search (lower_bound equivalent) to find the first palindrome >= median
    int low = 0, high = pal_count - 1;
    int idx_R = -1; // Index of the smallest palindrome >= median

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (palindromes[mid] >= median) {
            idx_R = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    // According to the property of convex functions over discrete sets, 
    // the optimal palindrome will be one of the two palindromes numerically closest to the median.

    // Candidate 1: p_R (the smallest palindrome >= median)
    // This handles cases where median is smaller than or equal to the smallest palindrome.
    if (idx_R != -1) {
        long long cost = calculate_cost(nums, numsSize, palindromes[idx_R]);
        min_total_cost = cost; // First cost found, initialize min_total_cost
    }

    // Candidate 2: p_L (the largest palindrome <= median)
    // This handles cases where median is larger than or equal to the largest palindrome
    // or when median is between two palindromes.
    if (idx_R > 0) { // Check if there is a palindrome before palindromes[idx_R]
        long long cost = calculate_cost(nums, numsSize, palindromes[idx_R - 1]);
        if (min_total_cost == -1 || cost < min_total_cost) {
            min_total_cost = cost;
        }
    }

    // Edge case: If median is larger than ALL palindromes (idx_R remains -1).
    // In this scenario, the optimal palindrome must be the largest available palindrome.
    if (idx_R == -1 && pal_count > 0) { 
        long long cost = calculate_cost(nums, numsSize, palindromes[pal_count - 1]);
        if (min_total_cost == -1 || cost < min_total_cost) {
            min_total_cost = cost;
        }
    }

    return min_total_cost;
}