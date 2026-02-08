#include <stdlib.h>

int distinctAverages(int* nums, int numsSize) {
    int* sums = (int*)malloc(numsSize / 2 * sizeof(int));
    int count = 0;
    int* seen = (int*)calloc(100001, sizeof(int));

    qsort(nums, numsSize, sizeof(int), cmp);

    for (int i = 0; i < numsSize / 2; i++) {
        sums[i] = nums[i] + nums[numsSize - 1 - i];
        if (!seen[sums[i]]) {
            seen[sums[i]] = 1;
            count++;
        }
    }

    free(sums);
    free(seen);
    return count;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}