#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int start;
    int end;
} Interval;

typedef struct {
    Interval *intervals;
    int size;
    int capacity;
    int count;
} CountIntervals;

CountIntervals* countIntervalsCreate() {
    CountIntervals* obj = (CountIntervals*)malloc(sizeof(CountIntervals));
    obj->intervals = (Interval*)malloc(sizeof(Interval) * 1000);
    obj->size = 0;
    obj->capacity = 1000;
    obj->count = 0;
    return obj;
}

void countIntervalsAdd(CountIntervals* obj, int left, int right) {
    int i = 0;
    while (i < obj->size) {
        if (right < obj->intervals[i].start) {
            break;
        } else if (left > obj->intervals[i].end) {
            i++;
        } else {
            left = (left < obj->intervals[i].start) ? left : obj->intervals[i].start;
            right = (right > obj->intervals[i].end) ? right : obj->intervals[i].end;
            obj->count -= (obj->intervals[i].end - obj->intervals[i].start + 1);
            for (int j = i; j < obj->size - 1; j++) {
                obj->intervals[j] = obj->intervals[j + 1];
            }
            obj->size--;
        }
    }

    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->intervals = (Interval*)realloc(obj->intervals, sizeof(Interval) * obj->capacity);
    }

    int j = obj->size;
    while (j > i) {
        obj->intervals[j] = obj->intervals[j - 1];
        j--;
    }
    obj->intervals[i].start = left;
    obj->intervals[i].end = right;
    obj->size++;
    obj->count += (right - left + 1);
}

int countIntervalsCount(CountIntervals* obj) {
    return obj->count;
}

void countIntervalsFree(CountIntervals* obj) {
    free(obj->intervals);
    free(obj);
}