#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int start;
    int end;
} Interval;

typedef struct {
    Interval *bookings;
    int count;
    int capacity;
} MyCalendar;

MyCalendar* myCalendarCreate() {
    MyCalendar* obj = (MyCalendar*) malloc(sizeof(MyCalendar));
    obj->count = 0;
    obj->capacity = 10;
    obj->bookings = (Interval*) malloc(sizeof(Interval) * obj->capacity);
    return obj;
}

bool myCalendarBook(MyCalendar* obj, int start, int end) {
    for (int i = 0; i < obj->count; i++) {
        Interval existing = obj->bookings[i];
        if (start < existing.end && end > existing.start) {
            return false;
        }
    }

    if (obj->count == obj->capacity) {
        obj->capacity *= 2;
        obj->bookings = (Interval*) realloc(obj->bookings, sizeof(Interval) * obj->capacity);
    }

    obj->bookings[obj->count].start = start;
    obj->bookings[obj->count].end = end;
    obj->count++;

    return true;
}

void myCalendarFree(MyCalendar* obj) {
    free(obj->bookings);
    free(obj);
}