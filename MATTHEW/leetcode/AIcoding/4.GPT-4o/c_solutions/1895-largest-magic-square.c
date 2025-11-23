int largestMagicSquare(int** A, int ARowSize, int AColSize) {
    int maxSize = 1;
    int dp[51][51] = {0};

    for (int i = 0; i < ARowSize; i++) {
        for (int j = 0; j < AColSize; j++) {
            dp[i][j] = A[i][j];
        }
    }

    for (int size = 2; size <= fmin(ARowSize, AColSize); size++) {
        for (int i = 0; i <= ARowSize - size; i++) {
            for (int j = 0; j <= AColSize - size; j++) {
                int sum = 0;
                for (int k = 0; k < size; k++) {
                    sum += dp[i][j + k];
                }
                int valid = 1;

                for (int k = 0; k < size; k++) {
                    int rowSum = 0, colSum = 0;
                    for (int l = 0; l < size; l++) {
                        rowSum += dp[i + k][j + l];
                        colSum += dp[i + l][j + k];
                    }
                    if (rowSum != sum || colSum != sum) {
                        valid = 0;
                        break;
                    }
                }

                int diag1 = 0, diag2 = 0;
                for (int k = 0; k < size; k++) {
                    diag1 += dp[i + k][j + k];
                    diag2 += dp[i + k][j + size - 1 - k];
                }

                if (diag1 != sum || diag2 != sum) {
                    valid = 0;
                }

                if (valid) {
                    maxSize = size;
                }
            }
        }
    }

    return maxSize;
}