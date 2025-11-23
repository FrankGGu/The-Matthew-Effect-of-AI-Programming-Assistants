#include <stdbool.h>
#include <string.h>

int distinctPrimeFactors(int* nums, int numsSize) {
    bool is_prime_factor[1001];
    memset(is_prime_factor, false, sizeof(is_prime_factor));

    for (int i = 0; i < numsSize; i++) {
        int n = nums[i];
        for (int d = 2; d * d <= n; d++) {
            if (n % d == 0) {
                is_prime_factor[d] = true;
                while (n % d == 0) {
                    n /= d;
                }
            }
        }
        if (n > 1) { // Remaining n is a prime factor
            is_prime_factor[n] = true;
        }
    }

    int count = 0;
    for (int i = 2; i <= 1000; i++) {
        if (is_prime_factor[i]) {
            count++;
        }
    }
    return count;
}