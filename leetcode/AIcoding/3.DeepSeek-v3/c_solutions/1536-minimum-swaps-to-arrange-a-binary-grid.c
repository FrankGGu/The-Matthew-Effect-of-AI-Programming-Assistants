int minSwaps(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int* trailingZeros = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        int count = 0;
        for (int j = n - 1; j >= 0; j--) {
            if (grid[i][j] == 0) {
                count++;
            } else {
                break;
            }
        }
        trailingZeros[i] = count;
    }

    int swaps = 0;

    for (int i = 0; i < n; i++) {
        int required = n - 1 - i;
        int current = -1;

        for (int j = i; j < n; j++) {
            if (trailingZeros[j] >= required) {
                current = j;
                break;
            }
        }

        if (current == -1) {
            free(trailingZeros);
            return -1;
        }

        for (int j = current; j > i; j--) {
            int temp = trailingZeros[j];
            trailingZeros[j] = trailingZeros[j - 1];
            trailingZeros[j - 1] = temp;
            swaps++;
        }
    }

    free(trailingZeros);
    return swaps;
}