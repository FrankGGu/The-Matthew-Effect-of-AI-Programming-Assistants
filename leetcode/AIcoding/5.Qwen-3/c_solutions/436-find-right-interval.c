#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int start;
    int index;
} Interval;

int compare(const void* a, const void* b) {
    return ((Interval*)a)->start - ((Interval*)b)->start;
}

int findRightInterval(Interval* intervals, int n) {
    Interval* sorted = (Interval*)malloc(n * sizeof(Interval));
    for (int i = 0; i < n; i++) {
        sorted[i].start = intervals[i].start;
        sorted[i].index = intervals[i].index;
    }
    qsort(sorted, n, sizeof(Interval), compare);

    int* result = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        int left = 0, right = n - 1;
        int res = -1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (sorted[mid].start >= intervals[i].start) {
                res = sorted[mid].index;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        result[i] = res;
    }

    return *result;
}