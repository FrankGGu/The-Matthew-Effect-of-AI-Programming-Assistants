#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDifference(int* nums, int numsSize) {
    if (numsSize <= 4) {
        return 0;
    }

    qsort(nums, numsSize, sizeof(int), (int (*)(const void *, const void *))cmpfunc);

    int ans = nums[numsSize - 1] - nums[0];

    int diff1 = nums[numsSize - 4] - nums[0];
    int diff2 = nums[numsSize - 3] - nums[1];
    int diff3 = nums[numsSize - 2] - nums[2];
    int diff4 = nums[numsSize - 1] - nums[3];

    ans = min(ans, diff1);
    ans = min(ans, diff2);
    ans = min(ans, diff3);
    ans = min(ans, diff4);

    return ans;
}

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int min(int a, int b) {
    return (a < b) ? a : b;
}