int[] constructArray(int n, int k) {
    int* result = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n - k - 1; i++) {
        result[i] = i + 1;
    }
    for (int i = 0; i <= k; i++) {
        result[n - k - 1 + i] = (i % 2 == 0) ? (n - (i / 2)) : (n - (k - (i / 2)));
    }
    return result;
}