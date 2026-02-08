#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int timeToMinutes(char *time) {
    int hour = (time[0] - '0') * 10 + (time[1] - '0');
    int minute = (time[3] - '0') * 10 + (time[4] - '0');
    return hour * 60 + minute;
}

int findMinDifference(char **timePoints, int timePointsSize) {
    int *minutes = (int *)malloc(timePointsSize * sizeof(int));
    for (int i = 0; i < timePointsSize; i++) {
        minutes[i] = timeToMinutes(timePoints[i]);
    }

    qsort(minutes, timePointsSize, sizeof(int), cmp);

    int minDiff = 1440; // max difference in minutes
    for (int i = 0; i < timePointsSize; i++) {
        int diff = (minutes[(i + 1) % timePointsSize] - minutes[i] + 1440) % 1440;
        if (diff < minDiff) {
            minDiff = diff;
        }
    }

    free(minutes);
    return minDiff;
}

int cmp(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}