#include <stdio.h>
#include <stdlib.h>

bool checkSubarraySum(int* nums, int numsSize, int k) {
    if (numsSize < 2) return false;
    int prefixSum = 0;
    int* modMap = (int*)calloc(numsSize + 1, sizeof(int));
    modMap[0] = -1;
    for (int i = 0; i < numsSize; i++) {
        prefixSum += nums[i];
        if (k != 0) prefixSum %= k;
        if (modMap[prefixSum] != 0 && i - modMap[prefixSum] >= 2) {
            free(modMap);
            return true;
        }
        if (modMap[prefixSum] == 0) {
            modMap[prefixSum] = i;
        }
    }
    free(modMap);
    return false;
}