int maxRotateFunction(int* A, int ASize) {
    int F = 0, sum = 0;
    for (int i = 0; i < ASize; i++) {
        F += i * A[i];
        sum += A[i];
    }
    int maxF = F;
    for (int i = 1; i < ASize; i++) {
        F = F + sum - ASize * A[ASize - i];
        maxF = maxF > F ? maxF : F;
    }
    return maxF;
}