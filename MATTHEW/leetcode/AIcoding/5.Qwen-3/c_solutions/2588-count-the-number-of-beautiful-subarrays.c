#include <stdio.h>
#include <stdlib.h>

int countBeautifulSubarrays(int* nums, int numsSize) {
    int prefixXor = 0;
    int count = 0;
    int* xorCount = (int*)calloc(1024, sizeof(int));
    xorCount[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        prefixXor ^= nums[i];
        count += xorCount[prefixXor];
        xorCount[prefixXor]++;
    }

    free(xorCount);
    return count;
}