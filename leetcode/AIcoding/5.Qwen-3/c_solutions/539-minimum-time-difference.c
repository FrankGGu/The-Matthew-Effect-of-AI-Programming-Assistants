#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

char* findMinDifference(char** timePoints, int timePointsSize) {
    int* times = (int*)malloc(timePointsSize * sizeof(int));
    for (int i = 0; i < timePointsSize; i++) {
        int h = (timePoints[i][0] - '0') * 10 + (timePoints[i][1] - '0');
        int m = (timePoints[i][3] - '0') * 10 + (timePoints[i][4] - '0');
        times[i] = h * 60 + m;
    }

    qsort(times, timePointsSize, sizeof(int), compare);

    int minDiff = 1440;
    for (int i = 1; i < timePointsSize; i++) {
        minDiff = fmin(minDiff, times[i] - times[i - 1]);
    }
    minDiff = fmin(minDiff, 1440 - (times[timePointsSize - 1] - times[0]));

    char* result = (char*)malloc(6 * sizeof(char));
    sprintf(result, "%02d:%02d", minDiff / 60, minDiff % 60);
    free(times);
    return result;
}