void backtrack(int start, int n, int k, int* combination, int** result, int* returnSize, int* returnColumnSizes) {
    if (k == 0) {
        result[*returnSize] = malloc(sizeof(int) * (n - start + 1));
        memcpy(result[*returnSize], combination, sizeof(int) * (n - start + 1));
        returnColumnSizes[*returnSize] = n - start + 1;
        (*returnSize)++;
        return;
    }
    for (int i = start; i <= n; i++) {
        combination[n - k] = i;
        backtrack(i + 1, n, k - 1, combination, result, returnSize, returnColumnSizes);
    }
}

int** combine(int n, int k, int* returnSize, int** returnColumnSizes) {
    int** result = malloc(sizeof(int*) * 1000);
    *returnColumnSizes = malloc(sizeof(int) * 1000);
    *returnSize = 0;
    int* combination = malloc(sizeof(int) * k);
    backtrack(1, n, k, combination, result, returnSize, *returnColumnSizes);
    free(combination);
    return result;
}