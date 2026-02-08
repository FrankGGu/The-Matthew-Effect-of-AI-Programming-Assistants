#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxMarkedIndices(int* nums, int numsSize){
    qsort(nums, numsSize, sizeof(int), compare);
    int i = 0, j = (numsSize + 1) / 2;
    int count = 0;
    while (i < (numsSize + 1) / 2 && j < numsSize) {
        if (2 * nums[i] <= nums[j]) {
            count += 2;
            i++;
            j++;
        } else {
            j++;
        }
    }
    return count;
}