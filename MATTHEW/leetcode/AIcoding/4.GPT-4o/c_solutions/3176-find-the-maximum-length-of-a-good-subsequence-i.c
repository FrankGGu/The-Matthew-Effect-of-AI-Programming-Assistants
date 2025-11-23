int maximumGood(int** statements, int statementsSize, int* statementsColSize) {
    int maxGood = 0;
    int total = 1 << statementsSize;

    for (int mask = 0; mask < total; mask++) {
        int valid = 1;
        int countGood = 0;

        for (int i = 0; i < statementsSize; i++) {
            if (mask & (1 << i)) {
                countGood++;
                for (int j = 0; j < statementsSize; j++) {
                    if (statements[i][j] == 1 && !(mask & (1 << j))) {
                        valid = 0;
                        break;
                    }
                    if (statements[i][j] == 0 && (mask & (1 << j))) {
                        valid = 0;
                        break;
                    }
                }
            }
            if (!valid) break;
        }

        if (valid) {
            if (countGood > maxGood) {
                maxGood = countGood;
            }
        }
    }

    return maxGood;
}