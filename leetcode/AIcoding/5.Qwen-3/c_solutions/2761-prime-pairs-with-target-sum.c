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

int* findPrimePairs(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            int sum = nums[i] + nums[j];
            if (is_prime(sum)) {
                result[*returnSize] = nums[i];
                (*returnSize)++;
                result[*returnSize] = nums[j];
                (*returnSize)++;
            }
        }
    }

    return result;
}