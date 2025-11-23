int minSwap(int* A, int ASize, int* B, int BSize) {
    int swap[ASize];
    int noSwap[ASize];
    for (int i = 0; i < ASize; i++) {
        swap[i] = noSwap[i] = ASize; 
    }
    noSwap[0] = 0;
    swap[0] = 1;

    for (int i = 1; i < ASize; i++) {
        if (A[i] > A[i - 1] && B[i] > B[i - 1]) {
            noSwap[i] = noSwap[i - 1];
            swap[i] = swap[i - 1] + 1;
        }
        if (A[i] > B[i - 1] && B[i] > A[i - 1]) {
            noSwap[i] = fmin(noSwap[i], swap[i - 1]);
            swap[i] = fmin(swap[i], noSwap[i - 1] + 1);
        }
    }
    return fmin(swap[ASize - 1], noSwap[ASize - 1]);
}