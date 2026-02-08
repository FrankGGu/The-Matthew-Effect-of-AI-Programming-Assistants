#include <stdio.h>
#include <stdlib.h>

int countPrimes(int n) {
    if (n < 2) return 0;
    int* isPrime = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        isPrime[i] = 1;
    }
    isPrime[0] = isPrime[1] = 0;
    for (int i = 2; i * i < n; i++) {
        if (isPrime[i]) {
            for (int j = i * i; j < n; j += i) {
                isPrime[j] = 0;
            }
        }
    }
    int count = 0;
    for (int i = 2; i < n; i++) {
        if (isPrime[i]) count++;
    }
    free(isPrime);
    return count;
}