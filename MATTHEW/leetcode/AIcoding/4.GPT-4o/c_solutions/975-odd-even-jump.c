int oddEvenJumps(int* A, int ASize) {
    if (ASize == 0) return 0;

    int odd[ASize], even[ASize];
    for (int i = 0; i < ASize; i++) {
        odd[i] = even[i] = 0;
    }
    odd[ASize - 1] = even[ASize - 1] = 1;

    int* indices = (int*)malloc(ASize * sizeof(int));
    for (int i = 0; i < ASize; i++) indices[i] = i;
    qsort(indices, ASize, sizeof(int), [](const void* a, const void* b) {
        return A[*(int*)a] - A[*(int*)b];
    });

    for (int i = ASize - 1; i >= 0; i--) {
        int index = indices[i];
        if (i < ASize - 1) {
            if (index + 1 < ASize && A[indices[i + 1]] >= A[index]) {
                odd[index] = even[indices[i + 1]];
            }
            if (index - 1 >= 0 && A[indices[i - 1]] <= A[index]) {
                even[index] = odd[indices[i - 1]];
            }
        }
    }

    int count = 0;
    for (int i = 0; i < ASize; i++) {
        count += odd[i];
    }

    free(indices);
    return count;
}