#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int start;
    int end;
    int value;
} Event;

int compareEvents(const void* a, const void* b) {
    Event* e1 = (Event*)a;
    Event* e2 = (Event*)b;
    return e1->end - e2->end;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int maxTwoEvents(int** events, int eventsSize, int* eventsColSize) {
    Event* sortedEvents = (Event*)malloc(eventsSize * sizeof(Event));
    for (int i = 0; i < eventsSize; i++) {
        sortedEvents[i].start = events[i][0];
        sortedEvents[i].end = events[i][1];
        sortedEvents[i].value = events[i][2];
    }
    qsort(sortedEvents, eventsSize, sizeof(Event), compareEvents);

    int* maxValues = (int*)malloc(eventsSize * sizeof(int));
    maxValues[0] = sortedEvents[0].value;
    for (int i = 1; i < eventsSize; i++) {
        maxValues[i] = max(maxValues[i - 1], sortedEvents[i].value);
    }

    int result = 0;
    for (int i = 0; i < eventsSize; i++) {
        int left = 0, right = i - 1;
        int best = -1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (sortedEvents[mid].end < sortedEvents[i].start) {
                best = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        if (best != -1) {
            result = max(result, maxValues[best] + sortedEvents[i].value);
        }
        result = max(result, sortedEvents[i].value);
    }
    free(sortedEvents);
    free(maxValues);
    return result;
}