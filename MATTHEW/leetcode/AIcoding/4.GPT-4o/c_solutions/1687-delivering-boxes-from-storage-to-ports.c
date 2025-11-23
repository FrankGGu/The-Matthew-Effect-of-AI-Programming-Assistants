int boxDelivering(int** boxes, int boxesSize, int* boxesColSize, int portsCount, int maxBoxes, int maxWeight) {
    int mod = 1e9 + 7;
    long long dp[boxesSize + 1];
    int weight[boxesSize + 1];
    int port[boxesSize + 1];

    for (int i = 0; i < boxesSize; i++) {
        weight[i + 1] = weight[i] + boxes[i][1];
        port[i + 1] = port[i] + (i > 0 && boxes[i][0] != boxes[i - 1][0]);
    }

    for (int i = 0; i <= boxesSize; i++) {
        dp[i] = (long long)1e10;
    }
    dp[0] = 0;

    for (int i = 1; i <= boxesSize; i++) {
        for (int j = i; j > 0; j--) {
            if (i - j + 1 > maxBoxes) break;
            if (weight[i] - weight[j - 1] > maxWeight) break;
            dp[i] = fmin(dp[i], dp[j - 1] + 1 + port[i] - port[j - 1]);
        }
    }

    return (int)(dp[boxesSize] % mod);
}