int **result;
int *columnSizes;
int resultSize;
int *candidates;
int candidatesSize;

int compare(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

void backtrack(int *current, int currentSize, int target, int start) {
    if (target == 0) {
        result[resultSize] = (int *)malloc(currentSize * sizeof(int));
        for (int i = 0; i < currentSize; i++) {
            result[resultSize][i] = current[i];
        }
        columnSizes[resultSize] = currentSize;
        resultSize++;
        return;
    }

    for (int i = start; i < candidatesSize; i++) {
        if (i > start && candidates[i] == candidates[i - 1]) {
            continue;
        }
        if (candidates[i] > target) {
            break;
        }
        current[currentSize] = candidates[i];
        backtrack(current, currentSize + 1, target - candidates[i], i + 1);
    }
}

int **combinationSum2(int *candidates, int candidatesSize, int target, int *returnSize, int **returnColumnSizes) {
    qsort(candidates, candidatesSize, sizeof(int), compare);

    result = (int **)malloc(1000 * sizeof(int *));
    columnSizes = (int *)malloc(1000 * sizeof(int));
    resultSize = 0;

    int *current = (int *)malloc(100 * sizeof(int));

    backtrack(current, 0, target, 0);

    *returnSize = resultSize;
    *returnColumnSizes = columnSizes;

    free(current);
    return result;
}