#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxPrimeDifference(int* nums, int numsSize) {
    int max_diff = -1;

    if (numsSize < 2) {
        return max_diff;
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (isPrime(nums[i]) && isPrime(nums[j])) {
                int diff = abs(nums[i] - nums[j]);
                if (diff > max_diff) {
                    max_diff = diff;
                }
            }
        }
    }

    return max_diff;
}

bool isPrime(int n) {
    if (n <= 1) return false;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return false;
    }
    return true;
}