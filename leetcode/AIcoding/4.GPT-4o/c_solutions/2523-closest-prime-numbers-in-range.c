#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

bool isPrime(int num) {
    if (num <= 1) return false;
    if (num <= 3) return true;
    if (num % 2 == 0 || num % 3 == 0) return false;
    for (int i = 5; i * i <= num; i += 6) {
        if (num % i == 0 || num % (i + 2) == 0) return false;
    }
    return true;
}

int* closestPrimes(int left, int right, int* returnSize) {
    int* primes = malloc((right - left + 1) * sizeof(int));
    int count = 0;

    for (int i = left; i <= right; i++) {
        if (isPrime(i)) {
            primes[count++] = i;
        }
    }

    int* result = malloc(2 * sizeof(int));
    *returnSize = 0;

    if (count < 2) {
        result[0] = result[1] = -1;
        *returnSize = 2;
        free(primes);
        return result;
    }

    int minDiff = right - left + 1;
    for (int i = 0; i < count - 1; i++) {
        int diff = primes[i + 1] - primes[i];
        if (diff < minDiff) {
            minDiff = diff;
            result[0] = primes[i];
            result[1] = primes[i + 1];
        }
    }

    *returnSize = 2;
    free(primes);
    return result;
}