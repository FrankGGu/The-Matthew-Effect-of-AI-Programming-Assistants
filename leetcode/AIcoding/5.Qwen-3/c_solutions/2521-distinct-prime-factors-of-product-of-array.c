#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int distinctPrimeFactors(int* nums, int numsSize) {
    int* primes = (int*)malloc(sizeof(int) * 1000);
    int primeCount = 0;
    int* isPrime = (int*)malloc(sizeof(int) * 1000);
    for (int i = 0; i < 1000; i++) {
        isPrime[i] = 1;
    }
    isPrime[0] = isPrime[1] = 0;
    for (int i = 2; i * i < 1000; i++) {
        if (isPrime[i]) {
            for (int j = i * i; j < 1000; j += i) {
                isPrime[j] = 0;
            }
        }
    }
    for (int i = 2; i < 1000; i++) {
        if (isPrime[i]) {
            primes[primeCount++] = i;
        }
    }
    int result = 0;
    int* factors = (int*)calloc(1000, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        int n = nums[i];
        for (int j = 0; j < primeCount && primes[j] * primes[j] <= n; j++) {
            if (n % primes[j] == 0) {
                factors[primes[j]] = 1;
                while (n % primes[j] == 0) {
                    n /= primes[j];
                }
            }
        }
        if (n > 1) {
            factors[n] = 1;
        }
    }
    for (int i = 2; i < 1000; i++) {
        if (factors[i]) {
            result++;
        }
    }
    free(primes);
    free(isPrime);
    free(factors);
    return result;
}