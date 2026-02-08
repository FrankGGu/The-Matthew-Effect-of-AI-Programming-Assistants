#include <stdlib.h> // For qsort, malloc, free

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minOperations(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return 0;
    }

    qsort(nums, numsSize, sizeof(int), compare);

    int* unique_nums = (int*)malloc(numsSize * sizeof(int));
    if (unique_nums == NULL) {
        return -1; 
    }

    int m = 0;
    if (numsSize > 0) {
        unique_nums[m++] = nums[0];
        for (int i = 1; i < numsSize; i++) {
            if (nums[i] != nums[i-1]) {
                unique_nums[m++] = nums[i];
            }
        }
    }

    int min_ops = numsSize;

    int right = 0;
    for (int left = 0; left < m; left++) {
        while (right < m && unique_nums[right] < unique_nums[left] + numsSize) {
            right++;
        }

        int count = right - left;

        if (numsSize - count < min_ops) {
            min_ops = numsSize - count;
        }
    }

    free(unique_nums);

    return min_ops;
}