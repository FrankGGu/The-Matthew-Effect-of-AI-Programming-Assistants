int minWastedSpace(int* A, int ASize, int** B, int BSize, int* returnSize) {
    long total = 0;
    for (int i = 0; i < ASize; ++i) total += A[i];

    int minWaste = INT_MAX;
    for (int i = 0; i < BSize; ++i) {
        long waste = 0;
        int capacity = B[i][0];
        if (capacity < A[ASize - 1]) continue;

        long currentWaste = 0;
        int j = 0;
        for (int k = 0; k < ASize; ++k) {
            if (j < B[i][0] - 1) {
                currentWaste += A[k];
                if (currentWaste > capacity) {
                    waste += (currentWaste - capacity);
                    currentWaste = A[k];
                    ++j;
                }
            } else {
                waste += A[k];
            }
        }
        if (currentWaste) waste += (currentWaste - capacity);
        minWaste = fmin(minWaste, waste);
    }

    return (minWaste == INT_MAX) ? -1 : minWaste;
}