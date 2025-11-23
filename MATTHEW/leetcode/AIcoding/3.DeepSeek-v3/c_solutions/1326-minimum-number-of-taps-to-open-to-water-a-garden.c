int minTaps(int n, int* ranges, int rangesSize) {
    int* intervals = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        intervals[i] = i;
    }

    for (int i = 0; i <= n; i++) {
        if (ranges[i] == 0) continue;
        int left = i - ranges[i] > 0 ? i - ranges[i] : 0;
        int right = i + ranges[i] < n ? i + ranges[i] : n;
        if (intervals[left] < right) {
            intervals[left] = right;
        }
    }

    int count = 0;
    int current_end = 0;
    int next_end = 0;

    for (int i = 0; i <= n; i++) {
        if (i > next_end) {
            return -1;
        }
        if (i > current_end) {
            count++;
            current_end = next_end;
        }
        if (intervals[i] > next_end) {
            next_end = intervals[i];
        }
    }

    free(intervals);
    return count;
}