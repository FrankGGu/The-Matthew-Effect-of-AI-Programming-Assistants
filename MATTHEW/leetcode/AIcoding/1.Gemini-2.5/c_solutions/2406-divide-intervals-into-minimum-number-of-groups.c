#include <stdlib.h>

typedef struct {
    int point;
    int type; // +1 for start, -1 for end
} Event;

int compareEvents(const void* a, const void* b) {
    Event* eventA = (Event*)a;
    Event* eventB = (Event*)b;

    if (eventA->point != eventB->point) {
        return eventA->point - eventB->point;
    }
    // If points are equal, process start events (+1) before end events (-1)
    return eventA->type - eventB->type;
}

int minGroups(int** intervals, int intervalsSize, int* intervalsColSize) {
    if (intervalsSize == 0) {
        return 0;
    }

    Event* events = (Event*)malloc(sizeof(Event) * intervalsSize * 2);
    if (events == NULL) {
        return 0; // Should not happen in LeetCode environment, but good practice
    }

    for (int i = 0; i < intervalsSize; i++) {
        events[2 * i].point = intervals[i][0];
        events[2 * i].type = 1; // Start event

        events[2 * i + 1].point = intervals[i][1] + 1; // End event at end + 1
        events[2 * i + 1].type = -1; // End event
    }

    qsort(events, intervalsSize * 2, sizeof(Event), compareEvents);

    int currentOverlap = 0;
    int maxOverlap = 0;

    for (int i = 0; i < intervalsSize * 2; i++) {
        currentOverlap += events[i].type;
        if (currentOverlap > maxOverlap) {
            maxOverlap = currentOverlap;
        }
    }

    free(events);
    return maxOverlap;
}