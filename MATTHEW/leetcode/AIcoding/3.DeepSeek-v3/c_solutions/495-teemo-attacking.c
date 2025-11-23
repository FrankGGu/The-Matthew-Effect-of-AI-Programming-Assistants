int findPoisonedDuration(int* timeSeries, int timeSeriesSize, int duration) {
    if (timeSeriesSize == 0) return 0;

    int total = 0;
    for (int i = 0; i < timeSeriesSize - 1; i++) {
        total += (timeSeries[i + 1] - timeSeries[i] < duration) ? 
                 (timeSeries[i + 1] - timeSeries[i]) : duration;
    }
    return total + duration;
}