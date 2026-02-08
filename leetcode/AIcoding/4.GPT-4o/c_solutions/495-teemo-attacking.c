int findPoisonedDuration(int* timeSeries, int timeSeriesSize, int duration) {
    int total = 0;
    for (int i = 1; i < timeSeriesSize; i++) {
        if (timeSeries[i] < timeSeries[i - 1] + duration) {
            total += timeSeries[i] - timeSeries[i - 1];
        } else {
            total += duration;
        }
    }
    total += duration; // Add the duration of the last attack
    return total;
}