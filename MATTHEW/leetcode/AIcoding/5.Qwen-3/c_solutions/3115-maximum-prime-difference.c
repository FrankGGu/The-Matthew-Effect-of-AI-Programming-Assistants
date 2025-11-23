#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int maxPrimeDifference(int* nums, int numsSize) {
    int isPrime(int n) {
        if (n < 2) return 0;
        for (int i = 2; i <= sqrt(n); i++) {
            if (n % i == 0) return 0;
        }
        return 1;
    }

    int maxPrime = -1, minPrime = -1;

    for (int i = 0; i < numsSize; i++) {
        if (isPrime(nums[i])) {
            if (maxPrime == -1 || nums[i] > maxPrime) {
                maxPrime = nums[i];
            }
            if (minPrime == -1 || nums[i] < minPrime) {
                minPrime = nums[i];
            }
        }
    }

    return maxPrime - minPrime;
}