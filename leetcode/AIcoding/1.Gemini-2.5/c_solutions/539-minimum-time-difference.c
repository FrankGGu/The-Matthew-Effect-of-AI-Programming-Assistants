#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <limits.h>
#include <math.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findMinDifference(char **timePoints, int timePointsSize) {
    int *minutes = (int *)malloc(sizeof(int) * timePointsSize);
    if (minutes == NULL) {
        return -1; // Handle memory allocation failure
    }

    for (int i = 0; i < timePointsSize; i++) {
        int hour, minute;
        sscanf(timePoints[i], "%d:%d", &hour, &minute);
        minutes[i] = hour * 60 + minute;
    }

    qsort(minutes, timePointsSize, sizeof(int), compare);

    int minDiff = INT_MAX;

    for (int i = 0; i < timePointsSize - 1; i++) {
        int diff = minutes[i+1] - minutes[i];
        if (diff < minDiff) {
            minDiff = diff;
        }
    }

    // Handle the wrap-around difference between the last and first time point
    int wrapAroundDiff = (24 * 60) - (minutes[timePointsSize - 1] - minutes[0]);
    if (wrapAroundDiff < minDiff) {
        minDiff = wrapAroundDiff;
    }

    free(minutes);
    return minDiff;
}