long long calculateCost(int m, int s, int pushCost, int moveCost) {
    int digits[4];
    digits[0] = m / 10;
    digits[1] = m % 10;
    digits[2] = s / 10;
    digits[3] = s % 10;

    long long currentCost = 0;
    int currentPos = 0; // Start at digit 0
    int firstDigitIndex = 0;

    while (firstDigitIndex < 3 && digits[firstDigitIndex] == 0) {
        firstDigitIndex++;
    }

    for (int i = firstDigitIndex; i < 4; i++) {
        if (digits[i] != currentPos) {
            currentCost += moveCost;
            currentPos = digits[i];
        }
        currentCost += pushCost;
    }
    return currentCost;
}

int minCostToSetCookingTime(int targetSeconds, int pushCost, int moveCost) {
    long long minTotalCost = -1;

    // Case 1: m minutes, s seconds
    // targetSeconds = m * 60 + s
    int s1 = targetSeconds % 60;
    int m1 = targetSeconds / 60;

    if (m1 <= 99) { // Valid minutes range [0, 99]
        long long cost1 = calculateCost(m1, s1, pushCost, moveCost);
        minTotalCost = cost1;
    }

    // Case 2: (m-1) minutes, (s+60) seconds
    // targetSeconds = (m-1) * 60 + (s+60)
    int s2 = targetSeconds % 60 + 60;
    int m2 = targetSeconds / 60 - 1;

    if (m2 >= 0 && m2 <= 99 && s2 <= 99) { // Valid minutes and seconds range [0, 99]
        long long cost2 = calculateCost(m2, s2, pushCost, moveCost);
        if (minTotalCost == -1 || cost2 < minTotalCost) {
            minTotalCost = cost2;
        }
    }

    return (int)minTotalCost;
}