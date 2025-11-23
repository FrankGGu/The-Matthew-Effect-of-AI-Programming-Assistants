int largestSumAfterKNegations(int* A, int ASize, int K) {
    qsort(A, ASize, sizeof(int), cmp);
    for (int i = 0; i < ASize && K > 0; i++) {
        if (A[i] < 0) {
            A[i] = -A[i];
            K--;
        }
    }
    if (K > 0 && K % 2 == 1) {
        int minIndex = 0;
        for (int i = 1; i < ASize; i++) {
            if (A[i] < A[minIndex]) {
                minIndex = i;
            }
        }
        A[minIndex] = -A[minIndex];
    }
    int sum = 0;
    for (int i = 0; i < ASize; i++) {
        sum += A[i];
    }
    return sum;
}

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}