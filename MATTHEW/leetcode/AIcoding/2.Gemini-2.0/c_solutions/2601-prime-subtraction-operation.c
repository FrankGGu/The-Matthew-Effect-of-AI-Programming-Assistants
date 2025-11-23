#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool primeSubOperation(int* nums, int numsSize){
    bool isPrime[1001];
    for (int i = 0; i <= 1000; i++) {
        isPrime[i] = true;
    }
    isPrime[0] = isPrime[1] = false;
    for (int p = 2; p * p <= 1000; p++) {
        if (isPrime[p]) {
            for (int i = p * p; i <= 1000; i += p) {
                isPrime[i] = false;
            }
        }
    }

    int prev = 0;
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        if (num <= prev) {
            return false;
        }

        int bestPrime = 0;
        for (int p = num - prev - 1; p >= 2; p--) {
            if (isPrime[p]) {
                bestPrime = p;
                break;
            }
        }

        if (bestPrime > 0) {
            nums[i] -= bestPrime;
        }
        prev = nums[i];
    }

    return true;
}