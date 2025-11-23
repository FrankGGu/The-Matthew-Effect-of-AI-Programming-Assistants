int** combine(int n, int k, int* returnSize, int** returnColumnSizes) {
    int maxCombinations = 1;
    for (int i = 1; i <= k; i++) {
        maxCombinations = maxCombinations * (n - i + 1) / i;
    }

    int** result = (int**)malloc(maxCombinations * sizeof(int*));
    *returnColumnSizes = (int*)malloc(maxCombinations * sizeof(int));
    *returnSize = 0;

    int* current = (int*)malloc(k * sizeof(int));

    for (int i = 0; i < k; i++) {
        current[i] = i + 1;
    }

    while (1) {
        result[*returnSize] = (int*)malloc(k * sizeof(int));
        for (int i = 0; i < k; i++) {
            result[*returnSize][i] = current[i];
        }
        (*returnColumnSizes)[*returnSize] = k;
        (*returnSize)++;

        int pos = k - 1;
        while (pos >= 0 && current[pos] == n - k + pos + 1) {
            pos--;
        }

        if (pos < 0) {
            break;
        }

        current[pos]++;
        for (int i = pos + 1; i < k; i++) {
            current[i] = current[i - 1] + 1;
        }
    }

    free(current);
    return result;
}