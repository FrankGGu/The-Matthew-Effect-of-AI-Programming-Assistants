int maximumGood(int** statements, int statementsSize, int* statementsColSize) {
    int maxGood = 0;
    for (int mask = 0; mask < (1 << statementsSize); mask++) {
        int isGood = 1, countGood = 0;
        for (int i = 0; i < statementsSize; i++) {
            if (mask & (1 << i)) {
                countGood++;
                for (int j = 0; j < statementsSize; j++) {
                    if (statements[i][j] == 1 && !(mask & (1 << j))) {
                        isGood = 0;
                        break;
                    }
                    if (statements[i][j] == 0 && (mask & (1 << j))) {
                        isGood = 0;
                        break;
                    }
                }
            }
            if (!isGood) break;
        }
        if (isGood) {
            if (countGood > maxGood) {
                maxGood = countGood;
            }
        }
    }
    return maxGood;
}