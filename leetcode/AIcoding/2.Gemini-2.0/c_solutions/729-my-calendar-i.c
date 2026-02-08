#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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
    obj->events = (Event*)malloc(sizeof(Event) * 10);
    obj->size = 0;
    obj->capacity = 10;
    return obj;
}

bool myCalendarBook(MyCalendar* obj, int start, int end) {
    for (int i = 0; i < obj->size; i++) {
        if (start < obj->events[i].end && end > obj->events[i].start) {
            return false;
        }
    }

    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->events = (Event*)realloc(obj->events, sizeof(Event) * obj->capacity);
    }

    obj->events[obj->size].start = start;
    obj->events[obj->size].end = end;
    obj->size++;
    return true;
}

void myCalendarFree(MyCalendar* obj) {
    free(obj->events);
    free(obj);
}