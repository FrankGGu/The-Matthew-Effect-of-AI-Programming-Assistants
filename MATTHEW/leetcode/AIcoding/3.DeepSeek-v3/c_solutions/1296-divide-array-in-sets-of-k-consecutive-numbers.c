#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

bool isPossibleDivide(int* nums, int numsSize, int k) {
    if (numsSize % k != 0) return false;

    qsort(nums, numsSize, sizeof(int), cmp);

    int *used = (int*)calloc(numsSize, sizeof(int));
    if (!used) return false;

    for (int i = 0; i < numsSize; i++) {
        if (used[i]) continue;

        int current = nums[i];
        int count = 0;
        int j = i;

        while (j < numsSize && count < k) {
            if (!used[j] && nums[j] == current + count) {
                used[j] = 1;
                count++;
            } else if (!used[j] && nums[j] > current + count) {
                free(used);
                return false;
            }
            j++;
        }

        if (count < k) {
            free(used);
            return false;
        }
    }

    free(used);
    return true;
}