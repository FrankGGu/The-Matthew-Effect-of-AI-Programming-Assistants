#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int start;
    int end;
} Event;

typedef struct {
    Event* events;
    int size;
    int capacity;
} MyCalendar;

MyCalendar* myCalendarCreate() {
    MyCalendar* obj = (MyCalendar*)malloc(sizeof(MyCalendar));
    obj->size = 0;
    obj->capacity = 1;
    obj->events = (Event*)malloc(obj->capacity * sizeof(Event));
    return obj;
}

int myCalendarBook(MyCalendar* obj, int start, int end) {
    for (int i = 0; i < obj->size; i++) {
        if (obj->events[i].start < end && obj->events[i].end > start) {
            return 0;
        }
    }
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->events = (Event*)realloc(obj->events, obj->capacity * sizeof(Event));
    }
    obj->events[obj->size].start = start;
    obj->events[obj->size].end = end;
    obj->size++;
    return 1;
}

void myCalendarFree(MyCalendar* obj) {
    free(obj->events);
    free(obj);
}