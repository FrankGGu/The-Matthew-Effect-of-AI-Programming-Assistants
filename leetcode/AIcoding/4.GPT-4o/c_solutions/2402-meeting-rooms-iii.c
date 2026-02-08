#define MAXN 100001

typedef struct {
    int start;
    int end;
} Interval;

int cmp(const void *a, const void *b) {
    Interval *ia = (Interval *)a;
    Interval *ib = (Interval *)b;
    return ia->start - ib->start;
}

int minMeetingRooms(Interval* intervals, int intervalsSize) {
    if (intervalsSize == 0) return 0;

    qsort(intervals, intervalsSize, sizeof(Interval), cmp);

    int *endTimes = (int *)malloc(sizeof(int) * intervalsSize);
    int roomCount = 0;

    for (int i = 0; i < intervalsSize; i++) {
        int j = 0;
        while (j < roomCount && endTimes[j] <= intervals[i].start) {
            j++;
        }
        if (j < roomCount) {
            endTimes[j] = intervals[i].end;
        } else {
            endTimes[roomCount++] = intervals[i].end;
        }
    }

    free(endTimes);
    return roomCount;
}