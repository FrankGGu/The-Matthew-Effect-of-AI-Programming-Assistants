#include <stdio.h>
#include <stdlib.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int nthSuperUglyNumber(int n, int* primes, int primesSize) {
    int* dp = (int*)malloc(n * sizeof(int));
    dp[0] = 1;
    int* pointers = (int*)malloc(primesSize * sizeof(int));
    for (int i = 0; i < primesSize; i++) {
        pointers[i] = 0;
    }

    for (int i = 1; i < n; i++) {
        int next = INT_MAX;
        for (int j = 0; j < primesSize; j++) {
            next = min(next, dp[pointers[j]] * primes[j]);
        }
        dp[i] = next;
        for (int j = 0; j < primesSize; j++) {
            if (dp[i] == dp[pointers[j]] * primes[j]) {
                pointers[j]++;
            }
        }
    }

    int result = dp[n - 1];
    free(dp);
    free(pointers);
    return result;
}