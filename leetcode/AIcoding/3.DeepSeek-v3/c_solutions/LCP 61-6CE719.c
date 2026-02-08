int temperatureTrend(int* temperatureA, int temperatureASize, int* temperatureB, int temperatureBSize) {
    int maxTrend = 0;
    int currentTrend = 0;

    for (int i = 1; i < temperatureASize; i++) {
        int trendA = (temperatureA[i] > temperatureA[i-1]) ? 1 : (temperatureA[i] < temperatureA[i-1]) ? -1 : 0;
        int trendB = (temperatureB[i] > temperatureB[i-1]) ? 1 : (temperatureB[i] < temperatureB[i-1]) ? -1 : 0;

        if (trendA == trendB) {
            currentTrend++;
        } else {
            if (currentTrend > maxTrend) {
                maxTrend = currentTrend;
            }
            currentTrend = 0;
        }
    }

    if (currentTrend > maxTrend) {
        maxTrend = currentTrend;
    }

    return maxTrend;
}