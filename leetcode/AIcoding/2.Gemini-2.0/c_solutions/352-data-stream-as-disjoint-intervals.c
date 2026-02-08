#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int start;
    int end;
} Interval;

typedef struct {
    Interval* intervals;
    int size;
    int capacity;
} SummaryRanges;

SummaryRanges* summaryRangesCreate() {
    SummaryRanges* obj = (SummaryRanges*)malloc(sizeof(SummaryRanges));
    obj->intervals = (Interval*)malloc(sizeof(Interval) * 1);
    obj->size = 0;
    obj->capacity = 1;
    return obj;
}

void summaryRangesAddNum(SummaryRanges* obj, int value) {
    int i = 0;
    while (i < obj->size) {
        if (obj->intervals[i].end + 1 < value) {
            i++;
        } else if (obj->intervals[i].end >= value) {
            return;
        } else if (obj->intervals[i].end + 1 == value) {
            obj->intervals[i].end = value;
            int j = i + 1;
            while (j < obj->size) {
                if (obj->intervals[j].start == value + 1) {
                    obj->intervals[i].end = obj->intervals[j].end;
                    for (int k = j; k < obj->size - 1; k++) {
                        obj->intervals[k] = obj->intervals[k + 1];
                    }
                    obj->size--;
                    return;
                } else {
                    break;
                }
            }
            return;
        } else if (obj->intervals[i].start - 1 > value) {
            break;
        } else if (obj->intervals[i].start <= value) {
            return;
        } else if (obj->intervals[i].start - 1 == value) {
            obj->intervals[i].start = value;
            int j = i - 1;
            if (j >= 0 && obj->intervals[j].end == value - 1) {
                obj->intervals[j].end = obj->intervals[i].end;
                for (int k = i; k < obj->size - 1; k++) {
                    obj->intervals[k] = obj->intervals[k + 1];
                }
                obj->size--;
            }
            return;
        }
    }
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->intervals = (Interval*)realloc(obj->intervals, sizeof(Interval) * obj->capacity);
    }
    for (int j = obj->size - 1; j >= i; j--) {
        obj->intervals[j + 1] = obj->intervals[j];
    }
    obj->intervals[i].start = value;
    obj->intervals[i].end = value;
    obj->size++;
    int j = i - 1;
    if (j >= 0 && obj->intervals[j].end == value - 1) {
        obj->intervals[j].end = value;
        int k = i + 1;
        if (k < obj->size && obj->intervals[k].start == value + 1) {
            obj->intervals[j].end = obj->intervals[k].end;
            for (int l = k; l < obj->size - 1; l++) {
                obj->intervals[l] = obj->intervals[l + 1];
            }
            obj->size--;
        }
    } else {
        int k = i + 1;
        if (k < obj->size && obj->intervals[k].start == value + 1) {
            obj->intervals[i].end = obj->intervals[k].end;
            for (int l = k; l < obj->size - 1; l++) {
                obj->intervals[l] = obj->intervals[l + 1];
            }
            obj->size--;
        }
    }
}

int** summaryRangesGetIntervals(SummaryRanges* obj, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(sizeof(int*) * obj->size);
    *returnColumnSizes = (int*)malloc(sizeof(int) * obj->size);
    for (int i = 0; i < obj->size; i++) {
        result[i] = (int*)malloc(sizeof(int) * 2);
        result[i][0] = obj->intervals[i].start;
        result[i][1] = obj->intervals[i].end;
        (*returnColumnSizes)[i] = 2;
    }
    *returnSize = obj->size;
    return result;
}

void summaryRangesFree(SummaryRanges* obj) {
    free(obj->intervals);
    free(obj);
}