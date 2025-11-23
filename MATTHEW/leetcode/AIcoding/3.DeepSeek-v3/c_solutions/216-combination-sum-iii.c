int** combinationSum3(int k, int n, int* returnSize, int** returnColumnSizes) {
    int maxCombinations = 200;
    int** result = (int**)malloc(maxCombinations * sizeof(int*));
    *returnColumnSizes = (int*)malloc(maxCombinations * sizeof(int));
    *returnSize = 0;

    int path[9];
    int pathSize = 0;

    void backtrack(int start, int remaining) {
        if (pathSize == k && remaining == 0) {
            result[*returnSize] = (int*)malloc(k * sizeof(int));
            for (int i = 0; i < k; i++) {
                result[*returnSize][i] = path[i];
            }
            (*returnColumnSizes)[*returnSize] = k;
            (*returnSize)++;
            return;
        }

        if (pathSize > k || remaining < 0) {
            return;
        }

        for (int i = start; i <= 9; i++) {
            if (i > remaining) break;
            path[pathSize++] = i;
            backtrack(i + 1, remaining - i);
            pathSize--;
        }
    }

    backtrack(1, n);
    return result;
}