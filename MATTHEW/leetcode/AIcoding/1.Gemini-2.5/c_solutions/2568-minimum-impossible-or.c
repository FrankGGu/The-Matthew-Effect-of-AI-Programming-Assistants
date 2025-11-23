#include <stdlib.h> // For qsort

static int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minimumImpossibleOR(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    int reachable_or_limit = 0; 

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        if (num > reachable_or_limit + 1) {
            return reachable_or_limit + 1;
        } else {
            reachable_or_limit |= num;
        }
    }

    return reachable_or_limit + 1;
}