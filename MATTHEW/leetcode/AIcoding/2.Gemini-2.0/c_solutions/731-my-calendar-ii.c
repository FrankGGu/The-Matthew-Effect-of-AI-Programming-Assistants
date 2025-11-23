#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int start;
    int end;
} Event;

typedef struct {
    Event *events;
    int size;
    int capacity;
} MyCalendarTwo;

MyCalendarTwo* myCalendarTwoCreate() {
    MyCalendarTwo* obj = (MyCalendarTwo*)malloc(sizeof(MyCalendarTwo));
    obj->events = (Event*)malloc(sizeof(Event) * 10);
    obj->size = 0;
    obj->capacity = 10;
    return obj;
}

bool myCalendarTwoBook(MyCalendarTwo* obj, int start, int end) {
    int overlaps = 0;
    for (int i = 0; i < obj->size; i++) {
        int s = obj->events[i].start;
        int e = obj->events[i].end;
        if (start < e && end > s) {
            int overlap_start = (start > s) ? start : s;
            int overlap_end = (end < e) ? end : e;

            int count = 0;
            for (int j = 0; j < obj->size; j++) {
                if (i == j) continue;
                int s2 = obj->events[j].start;
                int e2 = obj->events[j].end;
                if (overlap_start < e2 && overlap_end > s2) {
                    count++;
                }
            }
            if (count >= 1) return false;
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

void myCalendarTwoFree(MyCalendarTwo* obj) {
    free(obj->events);
    free(obj);
}