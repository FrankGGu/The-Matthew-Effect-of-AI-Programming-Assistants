/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the return arrays are stored as *returnColumnSizes.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int compare(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

void backtrack(int *nums, int numsSize, int **result, int *returnSize, int *returnColumnSizes, int *current, int *used) {
    if (current[0] == numsSize) {
        result[*returnSize] = (int*)malloc(numsSize * sizeof(int));
        memcpy(result[*returnSize], current + 1, numsSize * sizeof(int));
        returnColumnSizes[*returnSize] = numsSize;
        (*returnSize)++;
        return;
    }

    for (int i = 0; i < numsSize; i++) {
        if (used[i] || (i > 0 && nums[i] == nums[i-1] && !used[i-1])) {
            continue;
        }
        used[i] = 1;
        current[0]++;
        current[current[0]] = nums[i];
        backtrack(nums, numsSize, result, returnSize, returnColumnSizes, current, used);
        used[i] = 0;
        current[0]--;
    }
}

int** permuteUnique(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    qsort(nums, numsSize, sizeof(int), compare);

    int maxPermutations = 1;
    for (int i = 1; i <= numsSize; i++) {
        maxPermutations *= i;
    }

    int **result = (int**)malloc(maxPermutations * sizeof(int*));
    *returnColumnSizes = (int*)malloc(maxPermutations * sizeof(int));
    *returnSize = 0;

    int *current = (int*)calloc(numsSize + 1, sizeof(int));
    int *used = (int*)calloc(numsSize, sizeof(int));

    backtrack(nums, numsSize, result, returnSize, *returnColumnSizes, current, used);

    free(current);
    free(used);

    return result;
}