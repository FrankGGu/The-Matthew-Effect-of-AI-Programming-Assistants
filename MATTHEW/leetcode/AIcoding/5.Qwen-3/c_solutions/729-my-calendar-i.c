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
} MyCalendar;

MyCalendar* myCalendarCreate() {
    MyCalendar* obj = (MyCalendar*)malloc(sizeof(MyCalendar));
    obj->intervals = NULL;
    obj->size = 0;
    obj->capacity = 0;
    return obj;
}

int myCalendarBook(MyCalendar* obj, int start, int end) {
    for (int i = 0; i < obj->size; i++) {
        if (obj->intervals[i].start < end && obj->intervals[i].end > start) {
            return 0;
        }
    }
    if (obj->size == obj->capacity) {
        obj->capacity = (obj->capacity == 0) ? 1 : obj->capacity * 2;
        obj->intervals = (Interval*)realloc(obj->intervals, obj->capacity * sizeof(Interval));
    }
    obj->intervals[obj->size].start = start;
    obj->intervals[obj->size].end = end;
    obj->size++;
    return 1;
}

void myCalendarFree(MyCalendar* obj) {
    free(obj->intervals);
    free(obj);
}