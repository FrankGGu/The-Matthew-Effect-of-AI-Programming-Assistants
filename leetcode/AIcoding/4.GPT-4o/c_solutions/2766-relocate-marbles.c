#include <stdlib.h>

int* relocateMarbles(int* nums, int numsSize, int* returnSize) {
    int* positions = (int*)malloc(numsSize * sizeof(int));
    int posCount = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            positions[posCount++] = nums[i];
        }
    }
    qsort(positions, posCount, sizeof(int), cmp);
    *returnSize = posCount;
    return positions;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}