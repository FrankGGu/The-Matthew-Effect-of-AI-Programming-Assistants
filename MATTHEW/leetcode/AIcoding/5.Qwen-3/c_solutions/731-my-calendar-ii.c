#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int start;
    int end;
} Interval;

typedef struct {
    Interval* intervals;
    int size;
    int capacity;
} MyCalendarTwo;

MyCalendarTwo* myCalendarTwoCreate() {
    MyCalendarTwo* obj = (MyCalendarTwo*)malloc(sizeof(MyCalendarTwo));
    obj->intervals = NULL;
    obj->size = 0;
    obj->capacity = 0;
    return obj;
}

int isOverlap(Interval a, Interval b) {
    return a.start < b.end && b.start < a.end;
}

int myCalendarTwoBook(MyCalendarTwo* obj, int start, int end) {
    for (int i = 0; i < obj->size; i++) {
        if (isOverlap(obj->intervals[i], (Interval){start, end})) {
            for (int j = i + 1; j < obj->size; j++) {
                if (isOverlap(obj->intervals[i], obj->intervals[j])) {
                    return 0;
                }
            }
        }
    }

    if (obj->size == obj->capacity) {
        obj->capacity = obj->capacity ? obj->capacity * 2 : 1;
        obj->intervals = (Interval*)realloc(obj->intervals, obj->capacity * sizeof(Interval));
    }

    obj->intervals[obj->size++] = (Interval){start, end};
    return 1;
}