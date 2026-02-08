int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int maxTotalFruits(int** fruits, int fruitsSize, int* fruitsColSize, int startPos, int k) {
    int maxPos = 0;
    for (int i = 0; i < fruitsSize; i++) {
        maxPos = max(maxPos, fruits[i][0]);
    }

    int* prefix = (int*)calloc(maxPos + 2, sizeof(int));
    for (int i = 0; i < fruitsSize; i++) {
        prefix[fruits[i][0] + 1] = fruits[i][1];
    }
    for (int i = 1; i <= maxPos + 1; i++) {
        prefix[i] += prefix[i - 1];
    }

    int result = 0;
    for (int x = 0; x <= k; x++) {
        int leftSteps = x;
        int rightSteps = k - x;

        int leftBound = startPos - leftSteps;
        int rightBound = startPos + rightSteps;
        if (leftBound < 0) leftBound = 0;
        if (rightBound > maxPos) rightBound = maxPos;
        result = max(result, prefix[rightBound + 1] - prefix[leftBound]);

        leftBound = startPos - rightSteps;
        rightBound = startPos + leftSteps;
        if (leftBound < 0) leftBound = 0;
        if (rightBound > maxPos) rightBound = maxPos;
        result = max(result, prefix[rightBound + 1] - prefix[leftBound]);
    }

    free(prefix);
    return result;
}