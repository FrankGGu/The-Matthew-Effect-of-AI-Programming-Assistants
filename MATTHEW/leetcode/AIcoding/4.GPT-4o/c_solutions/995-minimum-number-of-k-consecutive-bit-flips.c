int minKBitFlips(int* A, int ASize, int K) {
    int flips = 0, flipCount = 0;
    int* flipStatus = (int*)calloc(ASize + 1, sizeof(int));

    for (int i = 0; i < ASize; i++) {
        flipCount ^= flipStatus[i];
        if ((A[i] ^ flipCount) == 0) {
            if (i + K > ASize) {
                free(flipStatus);
                return -1;
            }
            flips++;
            flipCount ^= 1;
            flipStatus[i + K] ^= 1;
        }
    }

    free(flipStatus);
    return flips;
}