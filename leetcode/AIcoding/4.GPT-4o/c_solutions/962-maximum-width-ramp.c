int maxWidthRamp(int* A, int ASize) {
    int maxWidth = 0;
    int* minIndex = (int*)malloc(ASize * sizeof(int));
    minIndex[0] = 0;

    for (int i = 1; i < ASize; i++) {
        minIndex[i] = (A[i] < A[minIndex[i - 1]]) ? i : minIndex[i - 1];
    }

    for (int j = ASize - 1; j > 0; j--) {
        while (minIndex[j] < j && A[minIndex[j]] <= A[j]) {
            maxWidth = (j - minIndex[j] > maxWidth) ? j - minIndex[j] : maxWidth;
            minIndex[j]--;
        }
    }

    free(minIndex);
    return maxWidth;
}