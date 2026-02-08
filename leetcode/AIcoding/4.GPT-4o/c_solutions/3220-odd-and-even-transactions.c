int oddEvenJumps(int* A, int ASize) {
    if (ASize == 0) return 0;
    if (ASize == 1) return 1;

    int* odd = (int*)malloc(ASize * sizeof(int));
    int* even = (int*)malloc(ASize * sizeof(int));
    odd[ASize - 1] = even[ASize - 1] = 1;

    for (int i = ASize - 2; i >= 0; i--) {
        int nextOdd = -1, nextEven = -1;
        for (int j = i + 1; j < ASize; j++) {
            if (A[j] >= A[i] && (nextOdd == -1 || A[nextOdd] > A[j])) {
                nextOdd = j;
            }
            if (A[j] <= A[i] && (nextEven == -1 || A[nextEven] < A[j])) {
                nextEven = j;
            }
        }
        if (nextOdd != -1) odd[i] = even[nextOdd];
        if (nextEven != -1) even[i] = odd[nextEven];
    }

    int result = 0;
    for (int i = 0; i < ASize; i++) {
        if (odd[i]) result++;
    }

    free(odd);
    free(even);
    return result;
}