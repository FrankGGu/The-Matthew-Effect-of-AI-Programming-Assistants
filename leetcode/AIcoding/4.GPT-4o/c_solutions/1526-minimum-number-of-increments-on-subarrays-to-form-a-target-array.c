int minIncrements(int* A, int ASize, int* target, int targetSize) {
    int totalIncrement = 0;
    for (int i = 0; i < targetSize; ++i) {
        if (i < ASize) {
            totalIncrement += target[i] > A[i] ? target[i] - A[i] : 0;
        } else {
            totalIncrement += target[i];
        }
    }
    return totalIncrement;
}