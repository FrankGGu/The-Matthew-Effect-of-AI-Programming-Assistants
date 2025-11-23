#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int cmpfunc(const void *a, const void *b) {
    int x = *(int*)a;
    int y = *(int*)b;
    if (abs(x) == abs(y)) {
        return y - x;
    }
    return abs(x) - abs(y);
}

int closestToZero(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmpfunc);
    return nums[0];
}