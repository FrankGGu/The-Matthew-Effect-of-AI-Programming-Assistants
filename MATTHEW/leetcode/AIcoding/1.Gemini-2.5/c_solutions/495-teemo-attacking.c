int findPoisonedDuration(int* timeSeries, int timeSeriesSize, int duration) {
    if (timeSeriesSize == 0 || duration == 0) {
        return 0;
    }

    int totalDuration = 0;
    for (int i = 0; i < timeSeriesSize - 1; i++) {
        totalDuration += fmin(timeSeries[i+1] - timeSeries[i], duration);
    }
    totalDuration += duration;

    return totalDuration;
}