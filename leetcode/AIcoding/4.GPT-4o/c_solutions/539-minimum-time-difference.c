#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

int toMinutes(char* time) {
    int hours = (time[0] - '0') * 10 + (time[1] - '0');
    int minutes = (time[3] - '0') * 10 + (time[4] - '0');
    return hours * 60 + minutes;
}

int findMinDifference(char** timePoints, int timePointsSize) {
    int* minutes = (int*)malloc(timePointsSize * sizeof(int));
    for (int i = 0; i < timePointsSize; i++) {
        minutes[i] = toMinutes(timePoints[i]);
    }

    qsort(minutes, timePointsSize, sizeof(int), (int(*)(const void*, const void*))compare);

    int minDiff = INT_MAX;
    for (int i = 1; i < timePointsSize; i++) {
        int diff = minutes[i] - minutes[i - 1];
        minDiff = fmin(minDiff, diff);
    }

    int wrapDiff = (1440 - minutes[timePointsSize - 1]) + minutes[0];
    minDiff = fmin(minDiff, wrapDiff);

    free(minutes);
    return minDiff;
}

int compare(const int* a, const int* b) {
    return *a - *b;
}