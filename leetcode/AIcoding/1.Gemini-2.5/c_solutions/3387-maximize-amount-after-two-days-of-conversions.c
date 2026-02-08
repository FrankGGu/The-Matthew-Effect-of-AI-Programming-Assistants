long long maximizeAmount(int initialAmount_int, int** conversions1, int conversions1Size, int* conversions1ColSize, int** conversions2, int conversions2Size, int* conversions2ColSize) {
    long long initialAmount = (long long)initialAmount_int;
    long long maxAmount = initialAmount;

    for (int i = -1; i < conversions1Size; ++i) {
        long long amountAfterDay1;

        if (i == -1) {
            amountAfterDay1 = initialAmount;
        } else {
            long long cost1 = (long long)conversions1[i][0];
            long long profit1 = (long long)conversions1[i][1];
            if (initialAmount < cost1) {
                continue;
            }
            amountAfterDay1 = initialAmount - cost1 + profit1;
        }

        for (int j = -1; j < conversions2Size; ++j) {
            long long finalAmount;

            if (j == -1) {
                finalAmount = amountAfterDay1;
            } else {
                long long cost2 = (long long)conversions2[j][0];
                long long profit2 = (long long)conversions2[j][1];
                if (amountAfterDay1 < cost2) {
                    continue;
                }
                finalAmount = amountAfterDay1 - cost2 + profit2;
            }

            if (finalAmount > maxAmount) {
                maxAmount = finalAmount;
            }
        }
    }

    return maxAmount;
}