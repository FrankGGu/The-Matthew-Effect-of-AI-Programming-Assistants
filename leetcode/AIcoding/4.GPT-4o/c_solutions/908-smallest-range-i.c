int smallestRangeI(int* A, int ASize, int K) {
    int max = A[0];
    int min = A[0];
    for (int i = 1; i < ASize; i++) {
        if (A[i] > max) max = A[i];
        if (A[i] < min) min = A[i];
    }
    int range = max - min;
    return range > 2 * K ? range - 2 * K : 0;
}