#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* closestNthElement(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    int* indices = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        indices[i] = i;
    }
    qsort(indices, numsSize, sizeof(int), compare);

    int* pos = (int*)malloc((numsSize + 1) * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        pos[i] = indices[i];
    }
    pos[numsSize] = numsSize;

    for (int i = 0; i < queriesSize; i++) {
        int k = queries[i][0];
        int x = queries[i][1];
        int left = 0;
        int right = numsSize - 1;
        int ans = -1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (nums[pos[mid]] < x) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        int idx = left;
        if (idx < numsSize && nums[pos[idx]] == x) {
            ans = pos[idx];
        } else if (idx > 0 && nums[pos[idx - 1]] == x) {
            ans = pos[idx - 1];
        }
        result[i] = ans;
    }

    *returnSize = queriesSize;
    free(pos);
    free(indices);
    return result;
}