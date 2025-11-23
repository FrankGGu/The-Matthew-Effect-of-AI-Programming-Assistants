/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** combinationSum(int* candidates, int candidatesSize, int target, int* returnSize, int** returnColumnSizes) {
    int** result = NULL;
    *returnSize = 0;
    *returnColumnSizes = NULL;

    int* path = (int*)malloc(1000 * sizeof(int));
    int pathSize = 0;

    void backtrack(int start, int currentSum) {
        if (currentSum == target) {
            result = realloc(result, (*returnSize + 1) * sizeof(int*));
            result[*returnSize] = (int*)malloc(pathSize * sizeof(int));
            for (int i = 0; i < pathSize; i++) {
                result[*returnSize][i] = path[i];
            }

            *returnColumnSizes = realloc(*returnColumnSizes, (*returnSize + 1) * sizeof(int));
            (*returnColumnSizes)[*returnSize] = pathSize;
            (*returnSize)++;
            return;
        }

        if (currentSum > target) {
            return;
        }

        for (int i = start; i < candidatesSize; i++) {
            path[pathSize++] = candidates[i];
            backtrack(i, currentSum + candidates[i]);
            pathSize--;
        }
    }

    backtrack(0, 0);
    free(path);
    return result;
}