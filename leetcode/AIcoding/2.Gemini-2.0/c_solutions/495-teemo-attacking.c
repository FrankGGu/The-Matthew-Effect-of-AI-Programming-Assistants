#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findPoisonedDuration(int* timeSeries, int timeSeriesSize, int duration){
    if (timeSeriesSize == 0) return 0;
    int totalDuration = 0;
    for (int i = 0; i < timeSeriesSize - 1; i++) {
        int diff = timeSeries[i+1] - timeSeries[i];
        totalDuration += (diff < duration) ? diff : duration;
    }
    totalDuration += duration;
    return totalDuration;
}