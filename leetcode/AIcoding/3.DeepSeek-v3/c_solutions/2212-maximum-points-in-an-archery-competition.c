int* maximumBobPoints(int numArrows, int* aliceArrows, int* returnSize) {
    int n = 12;
    int maxScore = 0;
    int bestMask = 0;

    for (int mask = 0; mask < (1 << n); mask++) {
        int arrowsUsed = 0;
        int score = 0;
        for (int i = 0; i < n; i++) {
            if (mask & (1 << i)) {
                arrowsUsed += aliceArrows[i] + 1;
                score += i;
            }
        }
        if (arrowsUsed <= numArrows && score > maxScore) {
            maxScore = score;
            bestMask = mask;
        }
    }

    int* result = (int*)calloc(n, sizeof(int));
    *returnSize = n;

    int remaining = numArrows;
    for (int i = 0; i < n; i++) {
        if (bestMask & (1 << i)) {
            result[i] = aliceArrows[i] + 1;
            remaining -= result[i];
        }
    }

    if (remaining > 0) {
        result[0] += remaining;
    }

    return result;
}