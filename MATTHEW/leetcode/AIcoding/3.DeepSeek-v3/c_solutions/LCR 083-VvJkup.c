/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are returned as *returnColumnSizes.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
void backtrack(int* nums, int numsSize, int** result, int* returnSize, int** returnColumnSizes, int* current, int* used) {
    if (numsSize == 0) {
        result[*returnSize] = (int*)malloc(sizeof(int) * numsSize);
        for (int i = 0; i < numsSize; i++) {
            result[*returnSize][i] = current[i];
        }
        (*returnColumnSizes)[*returnSize] = numsSize;
        (*returnSize)++;
        return;
    }

    for (int i = 0; i < numsSize; i++) {
        if (used[i]) continue;
        used[i] = 1;
        current[numsSize - 1] = nums[i];
        backtrack(nums, numsSize - 1, result, returnSize, returnColumnSizes, current, used);
        used[i] = 0;
    }
}

int** permute(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int total = 1;
    for (int i = 1; i <= numsSize; i++) {
        total *= i;
    }

    int** result = (int**)malloc(sizeof(int*) * total);
    *returnColumnSizes = (int*)malloc(sizeof(int) * total);
    *returnSize = 0;

    int* current = (int*)malloc(sizeof(int) * numsSize);
    int* used = (int*)calloc(numsSize, sizeof(int));

    backtrack(nums, numsSize, result, returnSize, returnColumnSizes, current, used);

    free(current);
    free(used);
    return result;
}