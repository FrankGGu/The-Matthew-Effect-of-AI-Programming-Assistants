int* countBits(int n, int* returnSize) {
    *returnSize = n + 1;
    int* result = (int*)malloc(*returnSize * sizeof(int));
    for (int i = 0; i <= n; i++) {
        result[i] = (i & 1) + result[i >> 1];
    }
    return result;
}