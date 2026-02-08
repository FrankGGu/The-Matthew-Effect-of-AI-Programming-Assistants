/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are returned as *returnColumnSizes.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */

int compare(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

void backtrack(int *candidates, int candidatesSize, int target, int start, 
               int *current, int currentSize, int **result, int *returnSize, 
               int **returnColumnSizes) {
    if (target == 0) {
        result[*returnSize] = (int*)malloc(currentSize * sizeof(int));
        memcpy(result[*returnSize], current, currentSize * sizeof(int));
        (*returnColumnSizes)[*returnSize] = currentSize;
        (*returnSize)++;
        return;
    }

    for (int i = start; i < candidatesSize; i++) {
        if (i > start && candidates[i] == candidates[i-1]) continue;
        if (candidates[i] > target) break;

        current[currentSize] = candidates[i];
        backtrack(candidates, candidatesSize, target - candidates[i], i + 1, 
                  current, currentSize + 1, result, returnSize, returnColumnSizes);
    }
}

int** combinationSum2(int* candidates, int candidatesSize, int target, int* returnSize, int** returnColumnSizes) {
    qsort(candidates, candidatesSize, sizeof(int), compare);

    int **result = (int**)malloc(1000 * sizeof(int*));
    *returnColumnSizes = (int*)malloc(1000 * sizeof(int));
    *returnSize = 0;

    int *current = (int*)malloc(100 * sizeof(int));

    backtrack(candidates, candidatesSize, target, 0, current, 0, result, returnSize, returnColumnSizes);

    free(current);
    return result;
}