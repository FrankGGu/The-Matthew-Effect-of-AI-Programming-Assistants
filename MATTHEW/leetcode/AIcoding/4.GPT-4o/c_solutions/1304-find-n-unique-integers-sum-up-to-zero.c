int* sumZero(int n, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;
    for (int i = 0; i < n / 2; i++) {
        result[i] = i + 1;
        result[n - 1 - i] = -(i + 1);
    }
    if (n % 2 != 0) {
        result[n / 2] = 0;
    }
    return result;
}