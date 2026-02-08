int** findSolution(int(*customfunction)(int, int), int z, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(100 * sizeof(int*));
    *returnColumnSizes = (int*)malloc(100 * sizeof(int));
    *returnSize = 0;

    for (int x = 1; x <= 1000; x++) {
        for (int y = 1; y <= 1000; y++) {
            if (customfunction(x, y) == z) {
                result[*returnSize] = (int*)malloc(2 * sizeof(int));
                result[*returnSize][0] = x;
                result[*returnSize][1] = y;
                (*returnColumnSizes)[*returnSize] = 2;
                (*returnSize)++;
            }
        }
    }

    return result;
}