#include <stdio.h>
#include <stdlib.h>

bool checkSubarraySum(int* nums, int numsSize, int k) {
    if (nums == NULL || numsSize < 2) return false;
    if (k == 0) {
        for (int i = 1; i < numsSize; i++) {
            if (nums[i] == nums[i - 1]) return true;
        }
        return false;
    }
    int prefixSum = 0;
    int* modMap = (int*)calloc(k, sizeof(int));
    modMap[0] = -1;
    for (int i = 0; i < numsSize; i++) {
        prefixSum += nums[i];
        int mod = prefixSum % k;
        if (mod < 0) mod += k;
        if (modMap[mod] != 0 && i - modMap[mod] >= 2) return true;
        if (modMap[mod] == 0) modMap[mod] = i;
    }
    free(modMap);
    return false;
}