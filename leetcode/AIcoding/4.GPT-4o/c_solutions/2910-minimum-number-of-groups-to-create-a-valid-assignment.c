int minGroups(int** intervals, int intervalsSize, int* intervalsColSize) {
    int maxGroups = 0;
    int maxEnd = 0;

    for (int i = 0; i < intervalsSize; i++) {
        if (intervals[i][1] > maxEnd) {
            maxEnd = intervals[i][1];
        }
    }

    int *count = (int *)calloc(maxEnd + 2, sizeof(int));

    for (int i = 0; i < intervalsSize; i++) {
        count[intervals[i][0]]++;
        count[intervals[i][1] + 1]--;
    }

    int currentGroups = 0;
    for (int i = 1; i <= maxEnd; i++) {
        currentGroups += count[i];
        if (currentGroups > maxGroups) {
            maxGroups = currentGroups;
        }
    }

    free(count);

    return maxGroups;
}