#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

bool* sieve(int n) {
    bool* isPrime = (bool*)malloc((n + 1) * sizeof(bool));
    memset(isPrime, true, (n + 1) * sizeof(bool));
    isPrime[0] = isPrime[1] = false;
    for (int i = 2; i * i <= n; i++) {
        if (isPrime[i]) {
            for (int j = i * i; j <= n; j += i) {
                isPrime[j] = false;
            }
        }
    }
    return isPrime;
}

int* closestPrimes(int left, int right, int* returnSize) {
    *returnSize = 2;
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = -1;
    result[1] = -1;

    bool* primes = sieve(right);
    int prev = -1;
    int minDiff = INT_MAX;

    for (int i = left; i <= right; i++) {
        if (primes[i]) {
            if (prev != -1) {
                int diff = i - prev;
                if (diff < minDiff) {
                    minDiff = diff;
                    result[0] = prev;
                    result[1] = i;
                }
            }
            prev = i;
        }
    }

    free(primes);
    return result;
}