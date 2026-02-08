typedef struct {
    int start;
    int end;
} Interval;

int maxFreeTime(Interval* intervals, int intervalsSize) {
    int totalFreeTime = 0;
    int currentEnd = 0;

    // Sort intervals by start time
    qsort(intervals, intervalsSize, sizeof(Interval), [](const void* a, const void* b) {
        return ((Interval*)a)->start - ((Interval*)b)->start;
    });

    for (int i = 0; i < intervalsSize; i++) {
        if (intervals[i].start > currentEnd) {
            totalFreeTime += intervals[i].start - currentEnd;
        }
        currentEnd = currentEnd > intervals[i].end ? currentEnd : intervals[i].end;
    }

    return totalFreeTime;
}