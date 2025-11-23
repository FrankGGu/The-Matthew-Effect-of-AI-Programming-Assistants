#include <stdio.h>
#include <stdlib.h>

long long maxSumAfterOperations(int* nums, int numsSize) {
    int* freq = (int*)calloc(numsSize, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    long long sum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (freq[i] > 0) {
            sum += (long long)i * i * freq[i];
        }
    }

    free(freq);
    return sum;
}