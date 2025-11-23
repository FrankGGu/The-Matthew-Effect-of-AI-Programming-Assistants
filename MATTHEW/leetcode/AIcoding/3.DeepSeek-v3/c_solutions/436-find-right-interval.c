/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
typedef struct {
    int start;
    int index;
} Interval;

int compare(const void* a, const void* b) {
    Interval* i1 = (Interval*)a;
    Interval* i2 = (Interval*)b;
    return i1->start - i2->start;
}

int binarySearch(Interval* intervals, int size, int target) {
    int left = 0, right = size - 1;
    int result = -1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (intervals[mid].start >= target) {
            result = intervals[mid].index;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    return result;
}

int* findRightInterval(int** intervals, int intervalsSize, int* intervalsColSize, int* returnSize) {
    *returnSize = intervalsSize;
    int* result = (int*)malloc(intervalsSize * sizeof(int));
    Interval* sorted = (Interval*)malloc(intervalsSize * sizeof(Interval));

    for (int i = 0; i < intervalsSize; i++) {
        sorted[i].start = intervals[i][0];
        sorted[i].index = i;
    }

    qsort(sorted, intervalsSize, sizeof(Interval), compare);

    for (int i = 0; i < intervalsSize; i++) {
        int end = intervals[i][1];
        result[i] = binarySearch(sorted, intervalsSize, end);
    }

    free(sorted);
    return result;
}