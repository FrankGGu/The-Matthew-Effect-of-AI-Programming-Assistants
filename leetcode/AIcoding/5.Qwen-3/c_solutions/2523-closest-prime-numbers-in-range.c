#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int is_prime(int n) {
    if (n < 2) return 0;
    for (int i = 2; i <= sqrt(n); i++) {
        if (n % i == 0) return 0;
    }
    return 1;
}

int* closestPrimes(int left, int right, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 0;

    int prev_prime = -1;
    for (int i = left; i <= right; i++) {
        if (is_prime(i)) {
            if (prev_prime != -1 && i - prev_prime < 1000000) {
                result[0] = prev_prime;
                result[1] = i;
                *returnSize = 2;
                return result;
            }
            prev_prime = i;
        }
    }

    return result;
}