#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>

int* closestPrimes(int left, int right, int* returnSize) {
    *returnSize = 2;
    int* result = (int*)malloc(sizeof(int) * 2);
    result[0] = -1;
    result[1] = -1;

    bool* is_prime = (bool*)malloc(sizeof(bool) * (right + 1));
    for (int i = 0; i <= right; ++i) {
        is_prime[i] = true;
    }
    if (right >= 0) is_prime[0] = false;
    if (right >= 1) is_prime[1] = false;

    for (int p = 2; p * p <= right; ++p) {
        if (is_prime[p]) {
            for (int i = p * p; i <= right; i += p)
                is_prime[i] = false;
        }
    }

    int* all_primes = (int*)malloc(sizeof(int) * (right + 1));
    int all_primes_count = 0;
    for (int i = 0; i <= right; ++i) {
        if (is_prime[i]) {
            all_primes[all_primes_count++] = i;
        }
    }

    int min_diff = INT_MAX;
    int ans_p1 = -1;
    int ans_p2 = -1;

    int first_prime_idx = -1;
    for (int i = 0; i < all_primes_count; ++i) {
        if (all_primes[i] >= left) {
            first_prime_idx = i;
            break;
        }
    }

    if (first_prime_idx == -1 || all_primes_count - first_prime_idx < 2) {
        free(is_prime);
        free(all_primes);
        return result;
    }

    for (int i = first_prime_idx; i < all_primes_count - 1; ++i) {
        int p1 = all_primes[i];
        int p2 = all_primes[i+1];

        if (p2 - p1 < min_diff) {
            min_diff = p2 - p1;
            ans_p1 = p1;
            ans_p2 = p2;
        }
    }

    result[0] = ans_p1;
    result[1] = ans_p2;

    free(is_prime);
    free(all_primes);
    return result;
}