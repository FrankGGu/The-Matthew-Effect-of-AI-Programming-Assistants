typedef struct {
    int start;
    int end;
    int score;
} Interval;

int cmp(const void* a, const void* b) {
    Interval* i1 = (Interval*)a;
    Interval* i2 = (Interval*)b;
    return i1->end - i2->end;
}

int binarySearch(Interval* intervals, int right, int target) {
    int left = 0;
    int result = -1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (intervals[mid].end <= target) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return result;
}

int maxTwoEvents(int** events, int eventsSize, int* eventsColSize) {
    Interval* intervals = (Interval*)malloc(eventsSize * sizeof(Interval));
    for (int i = 0; i < eventsSize; i++) {
        intervals[i].start = events[i][0];
        intervals[i].end = events[i][1];
        intervals[i].score = events[i][2];
    }

    qsort(intervals, eventsSize, sizeof(Interval), cmp);

    int* dp = (int*)malloc(eventsSize * sizeof(int));
    dp[0] = intervals[0].score;

    for (int i = 1; i < eventsSize; i++) {
        dp[i] = dp[i-1];
        int idx = binarySearch(intervals, i-1, intervals[i].start - 1);
        int current = intervals[i].score;
        if (idx != -1) {
            current += dp[idx];
        }
        if (current > dp[i]) {
            dp[i] = current;
        }
    }

    int result = dp[eventsSize-1];
    free(intervals);
    free(dp);
    return result;
}