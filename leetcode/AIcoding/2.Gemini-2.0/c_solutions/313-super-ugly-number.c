#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int nthSuperUglyNumber(int n, int* primes, int primesSize) {
    int* ugly = (int*)malloc(n * sizeof(int));
    int* ptr = (int*)calloc(primesSize, sizeof(int));
    ugly[0] = 1;
    for (int i = 1; i < n; i++) {
        int min = 2147483647;
        for (int j = 0; j < primesSize; j++) {
            if ((long long)primes[j] * ugly[ptr[j]] < min) {
                min = primes[j] * ugly[ptr[j]];
            }
        }
        ugly[i] = min;
        for (int j = 0; j < primesSize; j++) {
            if (primes[j] * ugly[ptr[j]] == min) {
                ptr[j]++;
            }
        }
    }
    int result = ugly[n - 1];
    free(ugly);
    free(ptr);
    return result;
}