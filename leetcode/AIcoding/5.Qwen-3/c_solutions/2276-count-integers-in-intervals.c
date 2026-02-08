#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int *data;
    int size;
} Interval;

typedef struct {
    int *intervals;
    int capacity;
    int count;
} Intervals;

Intervals* initIntervals() {
    Intervals *obj = (Intervals*)malloc(sizeof(Intervals));
    obj->capacity = 1;
    obj->intervals = (int*)malloc(obj->capacity * sizeof(int));
    obj->count = 0;
    return obj;
}

void addInterval(Intervals* obj, int left, int right) {
    int *new_intervals = (int*)malloc((obj->capacity + 2) * sizeof(int));
    int new_count = 0;
    int i = 0;
    while (i < obj->count && obj->intervals[i] < left) {
        new_intervals[new_count++] = obj->intervals[i++];
    }
    new_intervals[new_count++] = left;
    new_intervals[new_count++] = right;
    while (i < obj->count) {
        new_intervals[new_count++] = obj->intervals[i++];
    }
    free(obj->intervals);
    obj->intervals = new_intervals;
    obj->capacity += 2;
    obj->count = new_count;
}

int countIntervals(Intervals* obj) {
    int count = 0;
    for (int i = 0; i < obj->count; i += 2) {
        count += obj->intervals[i + 1] - obj->intervals[i] + 1;
    }
    return count;
}

void freeIntervals(Intervals* obj) {
    free(obj->intervals);
    free(obj);
}