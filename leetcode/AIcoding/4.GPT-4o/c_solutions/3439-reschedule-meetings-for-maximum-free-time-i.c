#include <stdlib.h>

struct Interval {
    int start;
    int end;
};

int compare(const void* a, const void* b) {
    return ((struct Interval*)a)->start - ((struct Interval*)b)->start;
}

int* maxFreeTime(struct Interval* intervals, int intervalsSize, int* returnSize) {
    if (intervalsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    qsort(intervals, intervalsSize, sizeof(struct Interval), compare);

    int* freeTimes = (int*)malloc(sizeof(int) * intervalsSize * 2);
    *returnSize = 0;

    int end = intervals[0].end;

    for (int i = 1; i < intervalsSize; i++) {
        if (intervals[i].start > end) {
            freeTimes[*returnSize] = end;
            freeTimes[*returnSize + 1] = intervals[i].start;
            *returnSize += 2;
        }
        end = end > intervals[i].end ? end : intervals[i].end;
    }

    return freeTimes;
}