int minGroups(int** intervals, int intervalsSize, int* intervalsColSize) {
    int max_end = 0;
    for (int i = 0; i < intervalsSize; i++) {
        if (intervals[i][1] > max_end) {
            max_end = intervals[i][1];
        }
    }

    int* diff = (int*)calloc(max_end + 2, sizeof(int));

    for (int i = 0; i < intervalsSize; i++) {
        diff[intervals[i][0]]++;
        diff[intervals[i][1] + 1]--;
    }

    int current = 0;
    int max_overlap = 0;
    for (int i = 1; i <= max_end; i++) {
        current += diff[i];
        if (current > max_overlap) {
            max_overlap = current;
        }
    }

    free(diff);
    return max_overlap;
}