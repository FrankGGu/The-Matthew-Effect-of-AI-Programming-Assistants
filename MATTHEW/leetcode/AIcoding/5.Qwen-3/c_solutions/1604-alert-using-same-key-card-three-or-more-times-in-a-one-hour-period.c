#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* keyCardId;
    int time;
} Event;

int compareEvents(const void* a, const void* b) {
    Event* eventA = (Event*)a;
    Event* eventB = (Event*)b;
    return eventA->time - eventB->time;
}

bool alertNames(char** keyName, int keyNameSize, char** keyTime, int keyTimeSize) {
    int n = keyNameSize;
    Event* events = (Event*)malloc(n * sizeof(Event));
    for (int i = 0; i < n; i++) {
        events[i].keyCardId = keyName[i];
        events[i].time = atoi(keyTime[i]);
    }

    qsort(events, n, sizeof(Event), compareEvents);

    for (int i = 0; i < n; i++) {
        int count = 1;
        for (int j = i + 1; j < n && events[j].time - events[i].time <= 60; j++) {
            if (strcmp(events[j].keyCardId, events[i].keyCardId) == 0) {
                count++;
                if (count >= 3) {
                    free(events);
                    return true;
                }
            } else {
                break;
            }
        }
    }

    free(events);
    return false;
}