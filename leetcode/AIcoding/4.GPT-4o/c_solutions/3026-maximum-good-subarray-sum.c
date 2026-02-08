int maximumGood(int** statements, int statementsSize, int* statementsColSize) {
    int maxGoodSum = 0;
    int n = statementsSize;
    int totalStates = 1 << n;

    for (int state = 0; state < totalStates; state++) {
        int isValid = 1;
        int goodCount = 0;

        for (int i = 0; i < n; i++) {
            if (state & (1 << i)) {
                goodCount++;
                for (int j = 0; j < n; j++) {
                    if (statements[i][j] == 1 && !(state & (1 << j))) {
                        isValid = 0;
                        break;
                    }
                    if (statements[i][j] == 0 && (state & (1 << j))) {
                        isValid = 0;
                        break;
                    }
                }
            }
            if (!isValid) break;
        }

        if (isValid) {
            maxGoodSum = maxGoodSum > goodCount ? maxGoodSum : goodCount;
        }
    }

    return maxGoodSum;
}