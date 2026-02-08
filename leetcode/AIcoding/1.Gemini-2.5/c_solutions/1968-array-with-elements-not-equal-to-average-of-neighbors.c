#include <stdlib.h>

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

void rearrangeArray(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    int* ans = (int*)malloc(sizeof(int) * numsSize);

    int left = 0;
    int right = numsSize - 1;
    for (int i = 0; i < numsSize; ++i) {
        if (i % 2 == 0) {
            ans[i] = nums[left++];
        } else {
            ans[i] = nums[right--];
        }
    }

    for (int i = 0; i < numsSize; ++i) {
        nums[i] = ans[i];
    }

    free(ans);
}