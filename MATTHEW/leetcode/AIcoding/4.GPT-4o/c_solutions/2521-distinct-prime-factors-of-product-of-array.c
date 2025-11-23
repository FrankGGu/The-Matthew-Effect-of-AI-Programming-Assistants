#include <stdio.h>
#include <stdlib.h>

int countDistinctPrimeFactors(int* nums, int numsSize) {
    int* isPrime = (int*)malloc(100001 * sizeof(int));
    for (int i = 0; i <= 100000; i++) isPrime[i] = 1;
    isPrime[0] = isPrime[1] = 0;

    for (int i = 2; i * i <= 100000; i++) {
        if (isPrime[i]) {
            for (int j = i * i; j <= 100000; j += i) {
                isPrime[j] = 0;
            }
        }
    }

    int* primeFactors = (int*)malloc(100001 * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        long long num = nums[i];
        for (int j = 2; j * j <= num; j++) {
            if (isPrime[j] && num % j == 0) {
                primeFactors[j] = 1;
                while (num % j == 0) num /= j;
            }
        }
        if (num > 1) {
            primeFactors[num] = 1;
        }
    }

    int count = 0;
    for (int i = 2; i <= 100000; i++) {
        if (primeFactors[i]) count++;
    }

    free(isPrime);
    free(primeFactors);
    return count;
}