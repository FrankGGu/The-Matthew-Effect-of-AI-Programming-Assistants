#include <stdio.h>
#include <stdlib.h>

bool hasContinuousSubarraySum(int* nums, int numsSize, int k) {
    if (nums == NULL || numsSize == 0) return false;

    int prefixMod = 0;
    int* modSet = (int*)malloc((k + 1) * sizeof(int));
    for (int i = 0; i <= k; i++) {
        modSet[i] = -1;
    }
    modSet[0] = 0;

    for (int i = 0; i < numsSize; i++) {
        prefixMod = (prefixMod + nums[i]) % k;
        if (modSet[prefixMod] != -1) {
            if (i - modSet[prefixMod] >= 2) {
                free(modSet);
                return true;
            }
        } else {
            modSet[prefixMod] = i + 1;
        }
    }

    free(modSet);
    return false;
}