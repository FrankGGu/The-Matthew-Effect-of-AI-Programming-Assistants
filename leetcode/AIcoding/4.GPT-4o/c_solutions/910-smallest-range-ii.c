int smallestRangeII(int* A, int ASize, int K) {
    if (ASize == 1) return 0;
    int maxA = A[0], minA = A[0];
    for (int i = 1; i < ASize; i++) {
        if (A[i] > maxA) maxA = A[i];
        if (A[i] < minA) minA = A[i];
    }
    int res = maxA - minA;
    for (int i = 0; i < ASize; i++) {
        int low = A[i] - K, high = A[i] + K;
        if (low > minA) {
            res = res < (high - minA) ? res : (high - minA);
        }
        if (high < maxA) {
            res = res < (maxA - low) ? res : (maxA - low);
        }
    }
    return res;
}