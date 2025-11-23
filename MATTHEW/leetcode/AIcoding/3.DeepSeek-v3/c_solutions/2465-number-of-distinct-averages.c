#include <stdlib.h>

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int distinctAverages(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);

    int count[201] = {0};
    int distinct = 0;

    for (int i = 0; i < numsSize / 2; i++) {
        int sum = nums[i] + nums[numsSize - 1 - i];
        if (count[sum] == 0) {
            distinct++;
            count[sum] = 1;
        }
    }

    return distinct;
}