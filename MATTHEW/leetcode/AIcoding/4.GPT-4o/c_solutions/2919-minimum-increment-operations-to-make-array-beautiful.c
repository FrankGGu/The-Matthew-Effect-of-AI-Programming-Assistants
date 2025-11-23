int minIncrementForUnique(int* A, int ASize) {
    if (ASize == 0) return 0;

    qsort(A, ASize, sizeof(int), cmp);
    int moves = 0;

    for (int i = 1; i < ASize; i++) {
        if (A[i] <= A[i - 1]) {
            moves += A[i - 1] - A[i] + 1;
            A[i] = A[i - 1] + 1;
        }
    }

    return moves;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}