#include <stdio.h>
#include <stdlib.h>

int** permute(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int** result = NULL;
    *returnSize = 0;
    *returnColumnSizes = NULL;

    int* used = (int*)malloc(numsSize * sizeof(int));
    int* current = (int*)malloc(numsSize * sizeof(int));
    int currentSize = 0;

    void backtrack() {
        if (currentSize == numsSize) {
            int* row = (int*)malloc(numsSize * sizeof(int));
            for (int i = 0; i < numsSize; i++) {
                row[i] = current[i];
            }
            (*returnSize)++;
            result = (int**)realloc(result, *returnSize * sizeof(int*));
            result[*returnSize - 1] = row;
            *returnColumnSizes = (int*)realloc(*returnColumnSizes, *returnSize * sizeof(int));
            (*returnColumnSizes)[*returnSize - 1] = numsSize;
            return;
        }

        for (int i = 0; i < numsSize; i++) {
            if (!used[i]) {
                used[i] = 1;
                current[currentSize++] = nums[i];
                backtrack();
                currentSize--;
                used[i] = 0;
            }
        }
    }

    backtrack();

    free(used);
    free(current);

    return result;
}