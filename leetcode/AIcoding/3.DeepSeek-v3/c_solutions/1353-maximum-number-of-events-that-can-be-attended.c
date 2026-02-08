#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    int* eventA = *(int**)a;
    int* eventB = *(int**)b;
    if (eventA[1] != eventB[1]) {
        return eventA[1] - eventB[1];
    }
    return eventA[0] - eventB[0];
}

int maxEvents(int** events, int eventsSize, int* eventsColSize) {
    qsort(events, eventsSize, sizeof(int*), cmp);

    int maxDay = 0;
    for (int i = 0; i < eventsSize; i++) {
        if (events[i][1] > maxDay) {
            maxDay = events[i][1];
        }
    }

    int* attended = (int*)calloc(maxDay + 2, sizeof(int));
    int count = 0;

    for (int i = 0; i < eventsSize; i++) {
        int start = events[i][0];
        int end = events[i][1];
        for (int day = start; day <= end; day++) {
            if (!attended[day]) {
                attended[day] = 1;
                count++;
                break;
            }
        }
    }

    free(attended);
    return count;
}