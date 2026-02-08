void backtrack(int n, int k, int start, int* returnSize, int** returnColumnSizes, int** combinations, int* combination, int depth) {
    if (depth == k) {
        combinations[*returnSize] = (int*)malloc(k * sizeof(int));
        memcpy(combinations[*returnSize], combination, k * sizeof(int));
        (*returnColumnSizes)[*returnSize] = k;
        (*returnSize)++;
        return;
    }
    for (int i = start; i <= n; i++) {
        combination[depth] = i;
        backtrack(n, k, i + 1, returnSize, returnColumnSizes, combinations, combination, depth + 1);
    }
}

int** combine(int n, int k, int* returnSize, int** returnColumnSizes) {
    int** combinations = (int**)malloc(1000 * sizeof(int*));
    int* combination = (int*)malloc(k * sizeof(int));
    *returnSize = 0;
    *returnColumnSizes = (int*)malloc(1000 * sizeof(int));
    backtrack(n, k, 1, returnSize, returnColumnSizes, combinations, combination, 0);
    free(combination);
    return combinations;
}