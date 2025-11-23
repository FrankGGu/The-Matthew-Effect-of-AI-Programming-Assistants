#include <stdlib.h>

void backtrack(int* nums, int numsSize, int** ans, int* returnSize, int* returnColumnSizes, int* temp, int tempSize, int start) {
    ans[*returnSize] = (int*)malloc(sizeof(int) * tempSize);
    for (int i = 0; i < tempSize; i++) {
        ans[*returnSize][i] = temp[i];
    }
    returnColumnSizes[*returnSize] = tempSize;
    (*returnSize)++;

    for (int i = start; i < numsSize; i++) {
        temp[tempSize] = nums[i];
        backtrack(nums, numsSize, ans, returnSize, returnColumnSizes, temp, tempSize + 1, i + 1);
    }
}

int** subsets(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int maxSize = 1 << numsSize;
    int** ans = (int**)malloc(maxSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(maxSize * sizeof(int));
    *returnSize = 0;
    int* temp = (int*)malloc(numsSize * sizeof(int));
    backtrack(nums, numsSize, ans, returnSize, *returnColumnSizes, temp, 0, 0);
    free(temp);
    return ans;
}