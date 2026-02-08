#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

char* abbreviateProduct(int start, int end) {
    long long suffix_prod_val = 1;
    int c2 = 0;
    int c5 = 0;
    double log_sum = 0.0;

    // A large enough threshold to keep suffix_prod_val from overflowing
    // while preserving enough digits for the '...' case (at least 5 digits + buffer)
    long long SUFFIX_OVERFLOW_THRESHOLD = 1000000000000000LL; // 10^15

    for (long long i = start; i <= end; i++) {
        log_sum += log10((double)i);
        long long current_num = i;

        while (current_num > 0 && current_num % 2 == 0) {
            c2++;
            current_num /= 2;
        }
        while (current_num > 0 && current_num % 5 == 0) {
            c5++;
            current_num /= 5;
        }

        suffix_prod_val *= current_num;

        // Keep suffix_prod_val within limits, but only if it's not needed for the "small" product case.
        // If the product is small, suffix_prod_val will not exceed 10^10 (max 10 digits).
        // So, this loop will only trigger for large products.
        while (suffix_prod_val >= SUFFIX_OVERFLOW_THRESHOLD) {
            suffix_prod_val /= 10;
        }
    }

    int total_zeros = (c2 < c5) ? c2 : c5;

    // Adjust counts for remaining 2s and 5s that contribute to the suffix (not zeros)
    c2 -= total_zeros;
    c5 -= total_zeros;

    // Multiply remaining 2s and 5s into suffix_prod_val
    for (int k = 0; k < c2; k++) {
        suffix_prod_val *= 2;
        while (suffix_prod_val >= SUFFIX_OVERFLOW_THRESHOLD) {
            suffix_prod_val /= 10;
        }
    }
    for (int k = 0; k < c5; k++) {
        suffix_prod_val *= 5;
        while (suffix_prod_val >= SUFFIX_OVERFLOW_THRESHOLD) {
            suffix_prod_val /= 10;
        }
    }

    char* result = (char*)malloc(sizeof(char) * 50); // Sufficiently large buffer

    long long num_total_digits = (long long)floor(log_sum) + 1;

    if (num_total_digits - total_zeros <= 10) {
        // Direct print case: P_no_zeros_eZ
        // suffix_prod_val already holds the correct P_no_zeros as it wouldn't have overflowed
        sprintf(result, "%llde%d", suffix_prod_val, total_zeros);
    } else {
        // Abbreviated case: prefix...suffixeZ
        long long final_suffix = suffix_prod_val;
        while (final_suffix >= 100000) { // Keep only the last 5 digits
            final_suffix /= 10;
        }

        double prefix_double = pow(10, log_sum - floor(log_sum));
        long long final_prefix = (long long)(prefix_double * 100000.0); // Get at least 5 digits
        while (final_prefix >= 100000) { // Ensure it's exactly 5 digits
            final_prefix /= 10;
        }

        sprintf(result, "%lld...%05llde%d", final_prefix, final_suffix, total_zeros);
    }

    return result;
}