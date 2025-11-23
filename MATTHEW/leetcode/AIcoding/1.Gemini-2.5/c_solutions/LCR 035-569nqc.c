#include <stdlib.h>
#include <string.h>
#include <limits.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findMinDifference(char ** timePoints, int timePointsSize) {
    if (timePointsSize > 1440) {
        return 0;
    }

    int *minutes = (int *)malloc(timePointsSize * sizeof(int));
    if (minutes == NULL) {
        return -1; 
    }

    for (int i = 0; i < timePointsSize; i++) {
        int hour = (timePoints[i][0] - '0') * 10 + (timePoints[i][1] - '0');
        int minute = (timePoints[i][3] - '0') * 10 + (timePoints[i][4] - '0');
        minutes[i] = hour * 60 + minute;
    }

    qsort(minutes, timePointsSize, sizeof(int), compare);

    int min_diff = INT_MAX;

    for (int i = 1; i < timePointsSize; i++) {
        int diff = minutes[i] - minutes[i-1];
        if (diff < min_diff) {
            min_diff = diff;
        }
    }

    int wrap_around_diff = (24 * 60 - minutes[timePointsSize - 1]) + minutes[0];
    if (wrap_around_diff < min_diff) {
        min_diff = wrap_around_diff;
    }

    free(minutes);

    return min_diff;
}