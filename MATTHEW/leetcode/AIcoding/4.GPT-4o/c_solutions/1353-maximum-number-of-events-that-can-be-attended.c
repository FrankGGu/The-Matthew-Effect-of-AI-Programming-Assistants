#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int start;
    int end;
} Event;

int cmp(const void *a, const void *b) {
    Event *eventA = (Event *)a;
    Event *eventB = (Event *)b;
    return eventA->end - eventB->end;
}

int maxEvents(int** events, int eventsSize, int* eventsColSize) {
    Event *eventList = (Event *)malloc(eventsSize * sizeof(Event));
    for (int i = 0; i < eventsSize; i++) {
        eventList[i].start = events[i][0];
        eventList[i].end = events[i][1];
    }
    qsort(eventList, eventsSize, sizeof(Event), cmp);

    int count = 0;
    int day = 0;

    for (int i = 0; i < eventsSize; i++) {
        if (eventList[i].start > day) {
            day++;
            count++;
        } else if (eventList[i].end >= day) {
            day++;
            count++;
        }
    }

    free(eventList);
    return count;
}