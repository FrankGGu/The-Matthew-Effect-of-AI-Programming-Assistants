int[] findZigzagSequence(int[] a, int n) {
    qsort(a, n, sizeof(int), cmp);
    int* result = malloc(n * sizeof(int));
    result[0] = a[0];
    for (int i = 1; i < n - 1; i++) {
        result[i] = a[i + 1];
    }
    result[n - 1] = a[0];
    return result;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}