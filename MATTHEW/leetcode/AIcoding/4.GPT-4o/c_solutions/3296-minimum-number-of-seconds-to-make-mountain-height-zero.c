int minimumSeconds(int* A, int ASize) {
    int totalSeconds = 0;
    for (int i = 0; i < ASize; i++) {
        if (A[i] > 0) {
            totalSeconds += A[i];
        }
    }
    return totalSeconds;
}