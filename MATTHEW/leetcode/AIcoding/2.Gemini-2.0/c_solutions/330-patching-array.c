#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minPatches(int* nums, int numsSize, int n) {
    long long miss = 1;
    int patched = 0, i = 0;
    while (miss <= n) {
        if (i < numsSize && nums[i] <= miss) {
            miss += nums[i++];
        } else {
            miss += miss;
            patched++;
        }
    }
    return patched;
}