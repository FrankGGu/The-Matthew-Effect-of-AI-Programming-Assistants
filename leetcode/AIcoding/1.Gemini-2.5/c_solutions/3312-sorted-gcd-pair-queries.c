#include <stdlib.h>
#include <string.h>

long long countPairs(int* nums, int numsSize, int k) {
    // The maximum possible value for nums[i] and k is 10^5.
    // We can fix MAX_VAL to this constraint.
    const int MAX_VAL = 100000;

    // freq[x] stores the count of number x in nums
    int* freq = (int*)calloc(MAX_VAL + 1, sizeof(int));
    if (freq == NULL) return -1; 

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    // multiples_count[x] stores the count of numbers in nums that are multiples of x
    int* multiples_count = (int*)calloc(MAX_VAL + 1, sizeof(int));
    if (multiples_count == NULL) {
        free(freq);
        return -1;
    }

    // Calculate multiples_count for each x
    // For each possible divisor 'i', iterate through its multiples 'j'
    // and sum the frequencies of those multiples.
    for (int i = 1; i <= MAX_VAL; i++) {
        for (int j = i; j <= MAX_VAL; j += i) {
            multiples_count[i] += freq[j];
        }
    }

    // F[g] stores the number of pairs (a, b) such that g divides gcd(a, b).
    // This is equivalent to counting pairs where both 'a' and 'b' are multiples of 'g'.
    // If there are 'N' numbers that are multiples of 'g', then there are N*(N-1)/2 such pairs.
    long long* F = (long long*)calloc(MAX_VAL + 1, sizeof(long long));
    if (F == NULL) {
        free(freq);
        free(multiples_count);
        return -1;
    }

    for (int g = 1; g <= MAX_VAL; g++) {
        long long count_g = multiples_count[g];
        F[g] = count_g * (count_g - 1) / 2;
    }

    // ans[g] stores the number of pairs (a, b) such that gcd(a, b) = g.
    long long* ans = (long long*)calloc(MAX_VAL + 1, sizeof(long long));
    if (ans == NULL) {
        free(freq);
        free(multiples_count);
        free(F);
        return -1;
    }

    long long total_valid_pairs = 0;

    // Calculate ans[g] using the inclusion-exclusion principle (Mobius inversion variant).
    // Iterate 'g' from MAX_VAL down to 1.
    // F[g] includes pairs whose GCD is g, 2g, 3g, etc.
    // To find pairs with exact GCD 'g', we subtract counts of pairs whose GCD is a multiple of 'g' (e.g., 2g, 3g, ...)
    // which have already been calculated (because we iterate downwards).
    for (int g = MAX_VAL; g >= 1; g--) {
        ans[g] = F[g];
        for (long long m_g = (long long)2 * g; m_g <= MAX_VAL; m_g += g) {
            ans[g] -= ans[m_g];
        }

        // If the current GCD 'g' is greater than or equal to 'k',
        // add the count of pairs with this GCD to the total.
        if (g >= k) {
            total_valid_pairs += ans[g];
        }
    }

    // Free allocated memory
    free(freq);
    free(multiples_count);
    free(F);
    free(ans);

    return total_valid_pairs;
}