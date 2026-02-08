#include <stdlib.h>

typedef struct {
    int** intervals;
    int size;
    int capacity;
} SummaryRanges;

SummaryRanges* summaryRangesCreate() {
    SummaryRanges* obj = (SummaryRanges*)malloc(sizeof(SummaryRanges));
    obj->size = 0;
    obj->capacity = 10;
    obj->intervals = (int**)malloc(obj->capacity * sizeof(int*));
    return obj;
}

void summaryRangesAddNum(SummaryRanges* obj, int value) {
    int left = 0, right = obj->size - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (obj->intervals[mid][0] <= value && value <= obj->intervals[mid][1]) {
            return;
        } else if (obj->intervals[mid][0] > value) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    int mergeLeft = -1, mergeRight = -1;
    if (left > 0 && obj->intervals[left - 1][1] + 1 == value) {
        mergeLeft = left - 1;
    }
    if (left < obj->size && obj->intervals[left][0] - 1 == value) {
        mergeRight = left;
    }

    if (mergeLeft != -1 && mergeRight != -1) {
        obj->intervals[mergeLeft][1] = obj->intervals[mergeRight][1];
        for (int i = mergeRight; i < obj->size - 1; i++) {
            obj->intervals[i] = obj->intervals[i + 1];
        }
        obj->size--;
        free(obj->intervals[obj->size]);
    } else if (mergeLeft != -1) {
        obj->intervals[mergeLeft][1] = value;
    } else if (mergeRight != -1) {
        obj->intervals[mergeRight][0] = value;
    } else {
        if (obj->size == obj->capacity) {
            obj->capacity *= 2;
            obj->intervals = (int**)realloc(obj->intervals, obj->capacity * sizeof(int*));
        }
        for (int i = obj->size; i > left; i--) {
            obj->intervals[i] = obj->intervals[i - 1];
        }
        obj->intervals[left] = (int*)malloc(2 * sizeof(int));
        obj->intervals[left][0] = value;
        obj->intervals[left][1] = value;
        obj->size++;
    }
}

int** summaryRangesGetIntervals(SummaryRanges* obj, int* retSize, int** retColSize) {
    *retSize = obj->size;
    *retColSize = (int*)malloc(obj->size * sizeof(int));
    for (int i = 0; i < obj->size; i++) {
        (*retColSize)[i] = 2;
    }
    int** result = (int**)malloc(obj->size * sizeof(int*));
    for (int i = 0; i < obj->size; i++) {
        result[i] = (int*)malloc(2 * sizeof(int));
        result[i][0] = obj->intervals[i][0];
        result[i][1] = obj->intervals[i][1];
    }
    return result;
}

void summaryRangesFree(SummaryRanges* obj) {
    for (int i = 0; i < obj->size; i++) {
        free(obj->intervals[i]);
    }
    free(obj->intervals);
    free(obj);
}