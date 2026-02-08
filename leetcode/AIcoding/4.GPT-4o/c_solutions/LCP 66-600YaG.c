int minMeetingRooms(int** intervals, int intervalsSize, int* intervalsColSize) {
    if (intervalsSize == 0) return 0;

    int* startTimes = (int*)malloc(intervalsSize * sizeof(int));
    int* endTimes = (int*)malloc(intervalsSize * sizeof(int));

    for (int i = 0; i < intervalsSize; i++) {
        startTimes[i] = intervals[i][0];
        endTimes[i] = intervals[i][1];
    }

    qsort(startTimes, intervalsSize, sizeof(int), cmp);
    qsort(endTimes, intervalsSize, sizeof(int), cmp);

    int rooms = 0, endIndex = 0;

    for (int startIndex = 0; startIndex < intervalsSize; startIndex++) {
        if (startTimes[startIndex] < endTimes[endIndex]) {
            rooms++;
        } else {
            endIndex++;
        }
    }

    free(startTimes);
    free(endTimes);

    return rooms;
}

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}