#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int start;
    int end;
} Event;

typedef struct {
    Event *events;
    int count;
    int capacity;
} MyCalendar;

MyCalendar* myCalendarCreate() {
    MyCalendar* obj = (MyCalendar*) malloc(sizeof(MyCalendar));
    obj->capacity = 10; 
    obj->events = (Event*) malloc(sizeof(Event) * obj->capacity);
    obj->count = 0;
    return obj;
}

bool myCalendarBook(MyCalendar* obj, int start, int end) {
    for (int i = 0; i < obj->count; i++) {
        if (obj->events[i].start < end && start < obj->events[i].end) {
            return false;
        }
    }

    if (obj->count == obj->capacity) {
        obj->capacity *= 2;
        obj->events = (Event*) realloc(obj->events, sizeof(Event) * obj->capacity);
    }

    obj->events[obj->count].start = start;
    obj->events[obj->count].end = end;
    obj->count++;

    return true;
}

void myCalendarFree(MyCalendar* obj) {
    free(obj->events);
    free(obj);
}