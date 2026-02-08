#include <stdio.h>
#include <stdlib.h>

int findPoisonedDuration(int* timeSeries, int timeSeriesSize, int duration) {
    if (timeSeries == NULL || timeSeriesSize == 0 || duration == 0) {
        return 0;
    }

    int total = 0;
    for (int i = 1; i < timeSeriesSize; i++) {
        int diff = timeSeries[i] - timeSeries[i - 1];
        if (diff >= duration) {
            total += duration;
        } else {
            total += diff;
        }
    }
    total += duration;
    return total;
}