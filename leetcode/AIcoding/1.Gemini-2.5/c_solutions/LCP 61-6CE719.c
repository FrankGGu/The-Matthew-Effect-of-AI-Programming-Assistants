int getTrend(int prevTemp, int currTemp) {
    if (currTemp > prevTemp) {
        return 1;
    } else if (currTemp < prevTemp) {
        return -1;
    } else {
        return 0;
    }
}

int temperatureTrend(int* temperatureA, int temperatureASize, int* temperatureB, int temperatureBSize) {
    int maxLength = 0;
    int currentLength = 0;

    for (int i = 1; i < temperatureASize; i++) {
        int trendA = getTrend(temperatureA[i-1], temperatureA[i]);
        int trendB = getTrend(temperatureB[i-1], temperatureB[i]);

        if (trendA == trendB) {
            currentLength++;
        } else {
            currentLength = 0;
        }

        if (currentLength > maxLength) {
            maxLength = currentLength;
        }
    }

    return maxLength;
}