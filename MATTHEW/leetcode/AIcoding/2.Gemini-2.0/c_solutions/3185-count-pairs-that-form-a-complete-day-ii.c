#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long countPairs(int* timeSeries, int timeSeriesSize, int duration) {
    long long count = 0;
    int end = -1;
    for (int i = 0; i < timeSeriesSize; i++) {
        if (timeSeries[i] > end) {
            count += duration;
        } else {
            count += timeSeries[i] + duration - end - 1;
        }
        end = timeSeries[i] + duration - 1;
    }
    return count;
}