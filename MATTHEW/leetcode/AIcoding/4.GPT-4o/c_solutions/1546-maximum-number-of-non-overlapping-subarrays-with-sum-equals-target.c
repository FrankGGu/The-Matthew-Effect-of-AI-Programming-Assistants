#include <stdio.h>
#include <stdlib.h>

#define MAX(a, b) ((a) > (b) ? (a) : (b))

int maxNonOverlapping(int* nums, int numsSize, int target) {
    int count = 0, sum = 0;
    int* prefixSum = (int*)calloc(numsSize + 1, sizeof(int));
    int* hashMap = (int*)calloc(numsSize + 1, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        prefixSum[i + 1] = sum;
    }

    hashMap[0] = 1;
    for (int i = 0; i < numsSize; i++) {
        if (hashMap[prefixSum[i + 1] - target]) {
            count++;
            sum = 0;
            hashMap = (int*)calloc(numsSize + 1, sizeof(int));
            hashMap[0] = 1;
        }
        hashMap[prefixSum[i + 1]] = 1;
    }

    free(prefixSum);
    free(hashMap);
    return count;
}