#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int eliminateMaximum(int* dist, int distSize, int* speed, int speedSize) {
    int arrival_times[distSize];
    for (int i = 0; i < distSize; i++) {
        arrival_times[i] = (dist[i] + speed[i] - 1) / speed[i];
    }

    qsort(arrival_times, distSize, sizeof(int), cmp);

    int eliminated = 0;
    for (int i = 0; i < distSize; i++) {
        if (arrival_times[i] > i) {
            eliminated++;
        } else {
            break;
        }
    }

    return eliminated;
}