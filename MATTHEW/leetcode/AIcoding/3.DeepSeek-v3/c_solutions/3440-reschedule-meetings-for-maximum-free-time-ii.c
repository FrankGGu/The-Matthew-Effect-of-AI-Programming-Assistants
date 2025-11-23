#include <stdlib.h>
#include <string.h>

typedef struct {
    int start;
    int end;
} Interval;

int cmp(const void* a, const void* b) {
    Interval* i1 = (Interval*)a;
    Interval* i2 = (Interval*)b;
    if (i1->start == i2->start) {
        return i1->end - i2->end;
    }
    return i1->start - i2->start;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int maxFreeTime(int eventCount, int** events, int k) {
    Interval* intervals = (Interval*)malloc(eventCount * sizeof(Interval));
    for (int i = 0; i < eventCount; i++) {
        intervals[i].start = events[i][0];
        intervals[i].end = events[i][1];
    }

    qsort(intervals, eventCount, sizeof(Interval), cmp);

    int* maxEnd = (int*)malloc(eventCount * sizeof(int));
    maxEnd[eventCount - 1] = intervals[eventCount - 1].end;
    for (int i = eventCount - 2; i >= 0; i--) {
        maxEnd[i] = max(intervals[i].end, maxEnd[i + 1]);
    }

    int res = 0;
    for (int i = 0; i < eventCount; i++) {
        int left = i + 1, right = eventCount - 1;
        int pos = eventCount;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (intervals[mid].start >= intervals[i].end + k) {
                pos = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        if (pos < eventCount) {
            res = max(res, maxEnd[pos] - intervals[i].end - k);
        }

        if (i > 0) {
            res = max(res, intervals[i].start - intervals[i - 1].end);
        }
    }

    free(intervals);
    free(maxEnd);
    return res;
}