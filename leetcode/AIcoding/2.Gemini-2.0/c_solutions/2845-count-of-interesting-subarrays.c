#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countInterestingSubarrays(int* nums, int numsSize, int modulo, int k) {
    int count = 0;
    int prefixMod[numsSize + 1];
    prefixMod[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefixMod[i + 1] = (prefixMod[i] + (nums[i] % modulo == k % modulo)) % modulo;
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j <= numsSize; j++) {
            if ((prefixMod[j] - prefixMod[i] + modulo) % modulo == 0) {
                count++;
            }
        }
    }
    return count;
}