#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

int findMinDifference(char **timePoints, int timePointsSize) {
    int *times = (int *)malloc(timePointsSize * sizeof(int));
    for (int i = 0; i < timePointsSize; i++) {
        int h = (timePoints[i][0] - '0') * 10 + (timePoints[i][1] - '0');
        int m = (timePoints[i][3] - '0') * 10 + (timePoints[i][4] - '0');
        times[i] = h * 60 + m;
    }
    qsort(times, timePointsSize, sizeof(int), compare);
    int minDiff = 1440;
    for (int i = 1; i < timePointsSize; i++) {
        minDiff = (times[i] - times[i - 1] < minDiff) ? times[i] - times[i - 1] : minDiff;
    }
    minDiff = (times[0] + 1440 - times[timePointsSize - 1] < minDiff) ? times[0] + 1440 - times[timePointsSize - 1] : minDiff;
    free(times);
    return minDiff;
}