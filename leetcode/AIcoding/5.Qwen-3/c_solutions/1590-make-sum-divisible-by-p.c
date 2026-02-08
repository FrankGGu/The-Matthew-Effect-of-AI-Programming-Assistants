#include <stdio.h>
#include <stdlib.h>

int minSubarray(int* nums, int numsSize, int p) {
    int n = numsSize;
    int prefixMod = 0;
    int minLen = n;
    int target = 0;
    for (int i = 0; i < n; i++) {
        prefixMod = (prefixMod + nums[i]) % p;
    }
    target = prefixMod % p;
    if (target == 0) return 0;

    int* modIndex = (int*)malloc(p * sizeof(int));
    for (int i = 0; i < p; i++) {
        modIndex[i] = -1;
    }
    modIndex[0] = -1;
    prefixMod = 0;
    for (int i = 0; i < n; i++) {
        prefixMod = (prefixMod + nums[i]) % p;
        int rem = (prefixMod - target + p) % p;
        if (modIndex[rem] != -1) {
            minLen = fmin(minLen, i - modIndex[rem]);
        }
        if (modIndex[prefixMod] == -1) {
            modIndex[prefixMod] = i;
        }
    }
    free(modIndex);
    return minLen == n ? -1 : minLen;
}