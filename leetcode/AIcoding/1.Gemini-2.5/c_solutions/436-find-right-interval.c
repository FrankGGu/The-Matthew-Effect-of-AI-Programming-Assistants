#include <stdlib.h> // For malloc, qsort
#include <stdio.h>  // For NULL, potentially for debugging but not in final solution

typedef struct {
    int start;
    int original_index;
} IntervalInfo;

int compareIntervalInfo(const void *a, const void *b) {
    return ((IntervalInfo *)a)->start - ((IntervalInfo *)b)->start;
}

int binarySearch(IntervalInfo *arr, int size, int target) {
    int low = 0;
    int high = size - 1;
    int result_idx = size; // Default to 'not found' or 'past end'

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid].start >= target) {
            result_idx = mid; // This element is a candidate, try to find an earlier one
            high = mid - 1;
        } else {
            low = mid + 1; // Current element's start is too small, look in the right half
        }
    }
    return result_idx;
}

int* findRightInterval(int** intervals, int intervalsSize, int* intervalsColSize, int* returnSize) {
    *returnSize = intervalsSize;
    int* result = (int*) malloc(intervalsSize * sizeof(int));
    if (result == NULL) {
        return NULL;
    }

    IntervalInfo* sorted_intervals = (IntervalInfo*) malloc(intervalsSize * sizeof(IntervalInfo));
    if (sorted_intervals == NULL) {
        free(result);
        return NULL;
    }

    for (int i = 0; i < intervalsSize; i++) {
        sorted_intervals[i].start = intervals[i][0];
        sorted_intervals[i].original_index = i;
    }

    qsort(sorted_intervals, intervalsSize, sizeof(IntervalInfo), compareIntervalInfo);

    for (int i = 0; i < intervalsSize; i++) {
        int target_end = intervals[i][1];
        int found_idx = binarySearch(sorted_intervals, intervalsSize, target_end);

        if (found_idx == intervalsSize) { // No interval found with start >= target_end
            result[i] = -1;
        } else {
            result[i] = sorted_intervals[found_idx].original_index;
        }
    }

    free(sorted_intervals);
    return result;
}