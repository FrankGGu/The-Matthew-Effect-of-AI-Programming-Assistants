int* constructArray(int n, int k, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;
    for (int i = 1; i <= n; i++) {
        result[i - 1] = i;
    }
    for (int i = 1; i <= k; i++) {
        if (i % 2 == 1) {
            // Odd index: fill from the end
            result[i - 1] = i / 2 + 1 + (k - i) / 2;
        } else {
            // Even index: fill from the start
            result[i - 1] = n - (k - i) / 2;
        }
    }
    return result;
}