#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    if (x[1] != y[1]) return x[1] - y[1];
    return x[0] - y[0];
}

int maxEvents(int** events, int eventsSize, int* eventsColSize) {
    qsort(events, eventsSize, sizeof(int*), compare);

    int count = 0;
    int last = -1;

    for (int i = 0; i < eventsSize; i++) {
        if (events[i][0] > last) {
            count++;
            last = events[i][1];
        }
    }

    return count;
}