#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int maximumProduct(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), cmp);
    for (int i = 0; i < k; i++) {
        nums[0]++;
        qsort(nums, numsSize, sizeof(int), cmp);
    }
    long long product = 1;
    for (int i = 0; i < numsSize; i++) {
        product = (product * nums[i]) % 1000000007;
    }
    return (int)product;
}