#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int distinctPrimeFactors(int* nums, int numsSize) {
    bool primes[1001] = {false};
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        for (int j = 2; j * j <= num; j++) {
            if (num % j == 0) {
                if (!primes[j]) {
                    primes[j] = true;
                    count++;
                }
                while (num % j == 0) {
                    num /= j;
                }
            }
        }
        if (num > 1) {
            if (!primes[num]) {
                primes[num] = true;
                count++;
            }
        }
    }

    return count;
}