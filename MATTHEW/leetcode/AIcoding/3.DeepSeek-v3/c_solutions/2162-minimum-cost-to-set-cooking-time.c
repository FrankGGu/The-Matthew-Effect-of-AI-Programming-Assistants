int minCostSetTime(int startAt, int moveCost, int pushCost, int targetSeconds) {
    int minCost = INT_MAX;

    for (int minutes = 0; minutes <= 99; minutes++) {
        for (int seconds = 0; seconds <= 99; seconds++) {
            if (minutes * 60 + seconds != targetSeconds) {
                continue;
            }

            char digits[5];
            int len = 0;

            if (minutes > 0) {
                if (minutes >= 10) {
                    digits[len++] = minutes / 10 + '0';
                    digits[len++] = minutes % 10 + '0';
                } else {
                    digits[len++] = minutes + '0';
                }
            }

            if (minutes > 0 || seconds >= 10) {
                digits[len++] = seconds / 10 + '0';
                digits[len++] = seconds % 10 + '0';
            } else {
                digits[len++] = seconds + '0';
            }

            digits[len] = '\0';

            int cost = 0;
            int current = startAt;

            for (int i = 0; i < len; i++) {
                int digit = digits[i] - '0';
                if (digit != current) {
                    cost += moveCost;
                    current = digit;
                }
                cost += pushCost;
            }

            if (cost < minCost) {
                minCost = cost;
            }
        }
    }

    return minCost;
}