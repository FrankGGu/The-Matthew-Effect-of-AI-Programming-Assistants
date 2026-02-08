#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* closestPrimes(int left, int right, int* returnSize) {
    bool isPrime[right + 1];
    for (int i = 0; i <= right; i++) {
        isPrime[i] = true;
    }
    isPrime[0] = isPrime[1] = false;

    for (int p = 2; p * p <= right; p++) {
        if (isPrime[p]) {
            for (int i = p * p; i <= right; i += p) {
                isPrime[i] = false;
            }
        }
    }

    int prevPrime = -1;
    int minDiff = INT_MAX;
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = -1;
    result[1] = -1;

    for (int i = left; i <= right; i++) {
        if (isPrime[i]) {
            if (prevPrime != -1) {
                int diff = i - prevPrime;
                if (diff < minDiff) {
                    minDiff = diff;
                    result[0] = prevPrime;
                    result[1] = i;
                }
            }
            prevPrime = i;
        }
    }

    *returnSize = (result[0] == -1) ? 0 : 2;
    return result;
}