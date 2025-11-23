#include <stdio.h>
#include <stdlib.h>

int subarraySum(int* nums, int numsSize, int k) {
    int count = 0;
    int* prefixSums = (int*)malloc((numsSize + 1) * sizeof(int));
    prefixSums[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefixSums[i + 1] = prefixSums[i] + nums[i];
    }
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j <= numsSize; j++) {
            if (prefixSums[j] - prefixSums[i] == k) {
                count++;
            }
        }
    }
    free(prefixSums);
    return count;
}