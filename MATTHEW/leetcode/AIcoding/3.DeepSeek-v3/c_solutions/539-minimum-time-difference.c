int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int findMinDifference(char** timePoints, int timePointsSize) {
    int* minutes = (int*)malloc(timePointsSize * sizeof(int));
    for (int i = 0; i < timePointsSize; i++) {
        int h = (timePoints[i][0] - '0') * 10 + (timePoints[i][1] - '0');
        int m = (timePoints[i][3] - '0') * 10 + (timePoints[i][4] - '0');
        minutes[i] = h * 60 + m;
    }

    qsort(minutes, timePointsSize, sizeof(int), compare);

    int minDiff = 1440;
    for (int i = 1; i < timePointsSize; i++) {
        int diff = minutes[i] - minutes[i - 1];
        if (diff < minDiff) {
            minDiff = diff;
        }
    }

    int circularDiff = 1440 - minutes[timePointsSize - 1] + minutes[0];
    if (circularDiff < minDiff) {
        minDiff = circularDiff;
    }

    free(minutes);
    return minDiff;
}