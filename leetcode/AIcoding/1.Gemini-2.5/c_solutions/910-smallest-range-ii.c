#include <stdlib.h> // Required for qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int smallestRangeII(int* A, int ASize, int K) {
    if (ASize <= 1) {
        return 0;
    }

    qsort(A, ASize, sizeof(int), compare);

    int ans = A[ASize - 1] - A[0];

    for (int i = 0; i < ASize - 1; i++) {
        // Calculate the maximum value in the modified array B for the current split.
        // It's the maximum of:
        // 1. The largest element in the first group (A[i]) after adding K.
        // 2. The largest element in the second group (A[ASize-1]) after subtracting K.
        int currentMax = (A[i] + K > A[ASize - 1] - K) ? (A[i] + K) : (A[ASize - 1] - K);

        // Calculate the minimum value in the modified array B for the current split.
        // It's the minimum of:
        // 1. The smallest element in the first group (A[0]) after adding K.
        // 2. The smallest element in the second group (A[i+1]) after subtracting K.
        int currentMin = (A[0] + K < A[i+1] - K) ? (A[0] + K) : (A[i+1] - K);

        // Update the overall minimum range found so far.
        ans = (ans < currentMax - currentMin) ? ans : (currentMax - currentMin);
    }

    return ans;
}