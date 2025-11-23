#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int time_to_minutes(char *time) {
    int hour = (time[0] - '0') * 10 + (time[1] - '0');
    int minute = (time[3] - '0') * 10 + (time[4] - '0');
    return hour * 60 + minute;
}

int cmp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

int findMinDifference(char **timePoints, int timePointsSize) {
    int minutes[timePointsSize];
    for (int i = 0; i < timePointsSize; i++) {
        minutes[i] = time_to_minutes(timePoints[i]);
    }

    qsort(minutes, timePointsSize, sizeof(int), cmp);

    int min_diff = INT_MAX;
    for (int i = 1; i < timePointsSize; i++) {
        int diff = minutes[i] - minutes[i - 1];
        if (diff < min_diff) {
            min_diff = diff;
        }
    }

    int last_diff = minutes[0] + 1440 - minutes[timePointsSize - 1];
    if (last_diff < min_diff) {
        min_diff = last_diff;
    }

    return min_diff;
}