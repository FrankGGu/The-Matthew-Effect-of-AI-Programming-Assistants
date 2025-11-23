int maxPoints(int** points, int pointsSize, int* pointsColSize) {
    int maxCol = *pointsColSize;
    int* dp = (int*)malloc(maxCol * sizeof(int));
    for (int j = 0; j < maxCol; j++) {
        dp[j] = points[0][j];
    }

    for (int i = 1; i < pointsSize; i++) {
        int* newDp = (int*)malloc(maxCol * sizeof(int));
        int leftMax = 0, rightMax = 0;

        for (int j = 0; j < maxCol; j++) {
            leftMax = fmax(leftMax, dp[j] + j);
            newDp[j] = leftMax - j + points[i][j];
        }

        for (int j = maxCol - 1; j >= 0; j--) {
            rightMax = fmax(rightMax, dp[j] - j);
            newDp[j] = fmax(newDp[j], rightMax + j + points[i][j]);
        }

        free(dp);
        dp = newDp;
    }

    int maxPoints = 0;
    for (int j = 0; j < maxCol; j++) {
        maxPoints = fmax(maxPoints, dp[j]);
    }

    free(dp);
    return maxPoints;
}