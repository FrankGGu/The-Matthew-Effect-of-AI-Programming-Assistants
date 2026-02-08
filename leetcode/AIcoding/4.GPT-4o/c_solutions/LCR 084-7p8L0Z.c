#include <stdio.h>
#include <stdlib.h>

void backtrack(int* nums, int numsSize, int* returnSize, int** returnColumnSizes, int** returnArray, int* returnIndex, int* visited) {
    if (*returnIndex == numsSize) {
        returnArray[*returnSize] = malloc(numsSize * sizeof(int));
        for (int i = 0; i < numsSize; i++) {
            returnArray[*returnSize][i] = nums[i];
        }
        (*returnColumnSizes)[*returnSize] = numsSize;
        (*returnSize)++;
        return;
    }

    for (int i = 0; i < numsSize; i++) {
        if (visited[i]) continue;
        if (i > 0 && nums[i] == nums[i - 1] && !visited[i - 1]) continue;

        visited[i] = 1;
        nums[*returnIndex] = nums[i];
        backtrack(nums, numsSize, returnSize, returnColumnSizes, returnArray, returnIndex + 1, visited);
        visited[i] = 0;
    }
}

int** permuteUnique(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int** returnArray = malloc(10000 * sizeof(int*));
    *returnColumnSizes = malloc(10000 * sizeof(int));
    *returnSize = 0;
    int* visited = calloc(numsSize, sizeof(int));
    qsort(nums, numsSize, sizeof(int), (int(*)(const void*, const void*))compare);
    backtrack(nums, numsSize, returnSize, returnColumnSizes, returnArray, 0, visited);
    free(visited);
    return returnArray;
}

int compare(const int* a, const int* b) {
    return (*a - *b);
}