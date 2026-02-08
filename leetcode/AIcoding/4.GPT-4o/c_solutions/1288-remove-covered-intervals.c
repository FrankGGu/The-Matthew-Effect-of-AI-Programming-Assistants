int removeCoveredIntervals(int** intervals, int intervalsSize, int* intervalsColSize) {
    qsort(intervals, intervalsSize, sizeof(int*), [](const void* a, const void* b) {
        if (((int**)a)[0][0] == ((int**)b)[0][0]) {
            return ((int**)a)[0][1] - ((int**)b)[0][1];
        }
        return ((int**)a)[0][0] - ((int**)b)[0][0];
    });

    int count = 0;
    int end = 0;

    for (int i = 0; i < intervalsSize; i++) {
        if (intervals[i][1] > end) {
            count++;
            end = intervals[i][1];
        }
    }

    return count;
}