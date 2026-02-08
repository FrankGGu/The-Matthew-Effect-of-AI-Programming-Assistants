#include <stdlib.h>
#include <string.h>

void backtrack(int* nums, int numsSize, bool* visited, int* temp, int tempSize, int** result, int* returnSize, int* returnColumnSizes) {
    if (tempSize == numsSize) {
        result[*returnSize] = malloc(numsSize * sizeof(int));
        memcpy(result[*returnSize], temp, numsSize * sizeof(int));
        returnColumnSizes[*returnSize] = numsSize;
        (*returnSize)++;
        return;
    }

    for (int i = 0; i < numsSize; i++) {
        if (visited[i]) continue;
        if (i > 0 && nums[i] == nums[i - 1] && !visited[i - 1]) continue;

        visited[i] = true;
        temp[tempSize] = nums[i];
        backtrack(nums, numsSize, visited, temp, tempSize + 1, result, returnSize, returnColumnSizes);
        visited[i] = false;
    }
}

int** permuteUnique(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int** result = malloc(10000 * sizeof(int*));
    *returnSize = 0;
    *returnColumnSizes = malloc(10000 * sizeof(int));

    bool* visited = calloc(numsSize, sizeof(bool));
    int* temp = malloc(numsSize * sizeof(int));

    qsort(nums, numsSize, sizeof(int), cmpfunc);
    backtrack(nums, numsSize, visited, temp, 0, result, returnSize, *returnColumnSizes);

    free(visited);
    free(temp);

    return result;
}

int cmpfunc(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}