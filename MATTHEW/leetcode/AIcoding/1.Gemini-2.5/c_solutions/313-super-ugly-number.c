#include <stdlib.h>
#include <limits.h>

int nthSuperUglyNumber(int n, int* primes, int primesSize) {
    if (n == 1) {
        return 1;
    }

    int* dp = (int*)malloc(sizeof(int) * n);
    dp[0] = 1;

    int* pointers = (int*)malloc(sizeof(int) * primesSize);
    for (int i = 0; i < primesSize; i++) {
        pointers[i] = 0;
    }

    long long* next_multiples = (long long*)malloc(sizeof(long long) * primesSize);
    for (int i = 0; i < primesSize; i++) {
        next_multiples[i] = (long long)primes[i] * dp[pointers[i]];
    }

    for (int i = 1; i < n; i++) {
        long long min_val = LLONG_MAX;
        for (int j = 0; j < primesSize; j++) {
            if (next_multiples[j] < min_val) {
                min_val = next_multiples[j];
            }
        }
        dp[i] = (int)min_val;

        for (int j = 0; j < primesSize; j++) {
            if (next_multiples[j] == min_val) {
                pointers[j]++;
                next_multiples[j] = (long long)primes[j] * dp[pointers[j]];
            }
        }
    }

    int result = dp[n - 1];

    free(dp);
    free(pointers);
    free(next_multiples);

    return result;
}