int maximumGood(int** statements, int statementsSize, int* statementsColSize) {
    int n = statementsSize;
    int maxGood = 0;

    for (int mask = 0; mask < (1 << n); mask++) {
        int valid = 1;

        for (int i = 0; i < n && valid; i++) {
            if (mask & (1 << i)) {
                for (int j = 0; j < n && valid; j++) {
                    if (statements[i][j] != 2) {
                        if (statements[i][j] == 0 && (mask & (1 << j))) {
                            valid = 0;
                        } else if (statements[i][j] == 1 && !(mask & (1 << j))) {
                            valid = 0;
                        }
                    }
                }
            }
        }

        if (valid) {
            int count = 0;
            for (int i = 0; i < n; i++) {
                if (mask & (1 << i)) count++;
            }
            if (count > maxGood) maxGood = count;
        }
    }

    return maxGood;
}