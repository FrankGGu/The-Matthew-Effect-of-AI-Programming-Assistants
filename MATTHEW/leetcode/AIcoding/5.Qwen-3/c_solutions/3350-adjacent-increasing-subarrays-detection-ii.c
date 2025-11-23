#include <stdio.h>
#include <stdlib.h>

bool checkSubarraySum(int* nums, int numsSize, int k) {
    if (numsSize < 2) return false;
    if (k == 0) {
        for (int i = 0; i < numsSize - 1; i++) {
            if (nums[i] == 0 && nums[i + 1] == 0) return true;
        }
        return false;
    }
    int* prefixMod = (int*)malloc(numsSize * sizeof(int));
    prefixMod[0] = nums[0] % k;
    for (int i = 1; i < numsSize; i++) {
        prefixMod[i] = (prefixMod[i - 1] + nums[i]) % k;
    }
    int* modIndex = (int*)calloc(k, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        int mod = prefixMod[i];
        if (mod == 0) return true;
        if (modIndex[mod] != 0) {
            if (i - modIndex[mod] >= 1) return true;
        } else {
            modIndex[mod] = i + 1;
        }
    }
    free(prefixMod);
    free(modIndex);
    return false;
}