#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    int* x = *(int**)a;
    int* y = *(int**)b;
    return x[1] - y[1];
}

int maxEvents(int** events, int eventsSize, int* eventsColSize){
    qsort(events, eventsSize, sizeof(int*), cmp);

    int attended = 0;
    int used[100001] = {0};

    for (int i = 0; i < eventsSize; i++) {
        int start = events[i][0];
        int end = events[i][1];

        for (int j = start; j <= end; j++) {
            if (used[j] == 0) {
                used[j] = 1;
                attended++;
                break;
            }
        }
    }

    return attended;
}