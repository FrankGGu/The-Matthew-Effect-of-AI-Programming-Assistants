#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int start;
    int end;
} Interval;

typedef struct {
    int* events;
    int size;
    int capacity;
} EventList;

typedef struct {
    EventList* starts;
    EventList* ends;
} MyCalendarThree;

MyCalendarThree* myCalendarThreeCreate() {
    MyCalendarThree* obj = (MyCalendarThree*)malloc(sizeof(MyCalendarThree));
    obj->starts = (EventList*)malloc(sizeof(EventList));
    obj->ends = (EventList*)malloc(sizeof(EventList));
    obj->starts->events = NULL;
    obj->starts->size = 0;
    obj->starts->capacity = 0;
    obj->ends->events = NULL;
    obj->ends->size = 0;
    obj->ends->capacity = 0;
    return obj;
}

void addEvent(EventList* list, int value) {
    if (list->size == list->capacity) {
        list->capacity = (list->capacity == 0) ? 1 : list->capacity * 2;
        list->events = (int*)realloc(list->events, list->capacity * sizeof(int));
    }
    list->events[list->size++] = value;
}

int myCalendarThreeBook(MyCalendarThree* obj, int start, int end) {
    addEvent(obj->starts, start);
    addEvent(obj->ends, end);

    qsort(obj->starts->events, obj->starts->size, sizeof(int), (int(*)(const void*, const void*))strcmp);
    qsort(obj->ends->events, obj->ends->size, sizeof(int), (int(*)(const void*, const void*))strcmp);

    int maxEvents = 0;
    int currentEvents = 0;
    int i = 0, j = 0;

    while (i < obj->starts->size && j < obj->ends->size) {
        if (obj->starts->events[i] < obj->ends->events[j]) {
            currentEvents++;
            i++;
            if (currentEvents > maxEvents) {
                maxEvents = currentEvents;
            }
        } else {
            currentEvents--;
            j++;
        }
    }

    return maxEvents;
}

void myCalendarThreeFree(MyCalendarThree* obj) {
    free(obj->starts->events);
    free(obj->starts);
    free(obj->ends->events);
    free(obj->ends);
    free(obj);
}