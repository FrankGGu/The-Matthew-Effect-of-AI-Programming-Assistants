#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

int minOperations(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), cmp);
    int ops = 0;
    int i = 0;
    while (numsSize > 1 && nums[0] < k) {
        nums[0] = nums[0] + 2 * nums[1];
        numsSize--;
        ops++;
        for (int j = 1; j < numsSize; j++) {
            nums[j] = nums[j+1];
        }
        qsort(nums, numsSize, sizeof(int), cmp);
    }
    return (nums[0] >= k) ? ops : -1;
}