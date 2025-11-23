#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxNumOfMarkedIndices(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    int count = 0;
    int i = 0;
    int j = numsSize / 2;

    while (i < numsSize / 2 && j < numsSize) {
        if ((long long)nums[i] * 2 <= nums[j]) {
            count += 2;
            i++;
            j++;
        } else {
            j++;
        }
    }

    return count;
}