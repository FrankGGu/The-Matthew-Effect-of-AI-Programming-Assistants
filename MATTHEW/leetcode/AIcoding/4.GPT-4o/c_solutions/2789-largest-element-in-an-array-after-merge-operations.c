int largestElementAfterMergeOperations(int* A, int ASize) {
    if (ASize == 0) return 0;
    long long maxElement = A[0];
    for (int i = 1; i < ASize; i++) {
        maxElement = maxElement > A[i] ? maxElement : A[i];
    }
    return (int)maxElement;
}