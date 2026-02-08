#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long maxProduct(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);
    for (int i = 0; i < numsSize - 1 && k > 0; i++) {
        int diff = nums[i + 1] - nums[i];
        if (diff <= k) {
            k -= diff;
            nums[i] += diff;
        } else {
            nums[i] += k;
            k = 0;
            break;
        }
    }
    if (k > 0) {
        nums[numsSize - 1] += k;
    }
    long long product = 1;
    for (int i = 0; i < numsSize; i++) {
        product *= nums[i];
    }
    return product;
}