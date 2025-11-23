#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long maxStrength(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    if (numsSize == 1) {
        return nums[0];
    }

    long long maxProduct = nums[0] * nums[1];
    if (numsSize >= 3) {
        maxProduct = fmax(maxProduct, (long long)nums[numsSize-1] * nums[numsSize-2]);
        maxProduct = fmax(maxProduct, (long long)nums[0] * nums[1] * nums[numsSize-1]);
        maxProduct = fmax(maxProduct, (long long)nums[0] * nums[numsSize-1] * nums[numsSize-2]);
    }

    return maxProduct;
}