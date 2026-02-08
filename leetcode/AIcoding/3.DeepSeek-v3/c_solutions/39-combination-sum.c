/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are returned as *returnColumnSizes.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** combinationSum(int* candidates, int candidatesSize, int target, int* returnSize, int** returnColumnSizes) {
    int maxCombinations = 1500;
    int** result = (int**)malloc(maxCombinations * sizeof(int*));
    *returnColumnSizes = (int*)malloc(maxCombinations * sizeof(int));
    *returnSize = 0;

    int* current = (int*)malloc(500 * sizeof(int));
    int currentSize = 0;

    void backtrack(int start, int remaining) {
        if (remaining == 0) {
            result[*returnSize] = (int*)malloc(currentSize * sizeof(int));
            for (int i = 0; i < currentSize; i++) {
                result[*returnSize][i] = current[i];
            }
            (*returnColumnSizes)[*returnSize] = currentSize;
            (*returnSize)++;
            return;
        }

        for (int i = start; i < candidatesSize; i++) {
            if (candidates[i] <= remaining) {
                current[currentSize++] = candidates[i];
                backtrack(i, remaining - candidates[i]);
                currentSize--;
            }
        }
    }

    backtrack(0, target);

    free(current);
    return result;
}