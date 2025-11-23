int maxSumDivK(int* A, int ASize, int K) {
    int maxSum = 0;
    int sum = 0;
    int modSum[K];
    for (int i = 0; i < K; i++) {
        modSum[i] = -1;
    }
    modSum[0] = 0;

    for (int i = 0; i < ASize; i++) {
        sum += A[i];
        if (modSum[(i + 1) % K] != -1) {
            maxSum = fmax(maxSum, sum - modSum[(i + 1) % K]);
        }
        modSum[(i + 1) % K] = fmax(modSum[(i + 1) % K], sum);
    }

    return maxSum;
}