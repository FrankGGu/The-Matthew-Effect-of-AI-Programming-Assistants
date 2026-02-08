int cmp(const void* a, const void* b) {
    int* interval1 = *(int**)a;
    int* interval2 = *(int**)b;
    if (interval1[0] == interval2[0]) {
        return interval2[1] - interval1[1];
    }
    return interval1[0] - interval2[0];
}

int removeCoveredIntervals(int** intervals, int intervalsSize, int* intervalsColSize) {
    qsort(intervals, intervalsSize, sizeof(int*), cmp);

    int count = 0;
    int max_end = -1;

    for (int i = 0; i < intervalsSize; i++) {
        if (intervals[i][1] > max_end) {
            count++;
            max_end = intervals[i][1];
        }
    }

    return count;
}