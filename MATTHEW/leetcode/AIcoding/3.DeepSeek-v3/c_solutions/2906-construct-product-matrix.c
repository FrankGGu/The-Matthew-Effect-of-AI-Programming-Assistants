/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** constructProductMatrix(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    int n = gridSize;
    int m = gridColSize[0];
    int total = n * m;
    int mod = 12345;

    long long *prefix = (long long*)malloc(total * sizeof(long long));
    long long *suffix = (long long*)malloc(total * sizeof(long long));

    prefix[0] = 1;
    for (int i = 1; i < total; i++) {
        int row = (i - 1) / m;
        int col = (i - 1) % m;
        prefix[i] = (prefix[i - 1] * (grid[row][col] % mod)) % mod;
    }

    suffix[total - 1] = 1;
    for (int i = total - 2; i >= 0; i--) {
        int row = (i + 1) / m;
        int col = (i + 1) % m;
        suffix[i] = (suffix[i + 1] * (grid[row][col] % mod)) % mod;
    }

    int** result = (int**)malloc(n * sizeof(int*));
    *returnColumnSizes = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        result[i] = (int*)malloc(m * sizeof(int));
        (*returnColumnSizes)[i] = m;
    }

    for (int i = 0; i < total; i++) {
        int row = i / m;
        int col = i % m;
        result[row][col] = (prefix[i] * suffix[i]) % mod;
    }

    free(prefix);
    free(suffix);

    *returnSize = n;
    return result;
}