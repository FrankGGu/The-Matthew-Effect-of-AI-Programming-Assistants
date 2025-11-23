#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int compare(const void *a, const void *b) {
    return (*(double*)a - *(double*)b);
}

int eliminateMaximum(int* dist, int distSize, int* speed, int speedSize) {
    double timeToReach[distSize];
    for (int i = 0; i < distSize; i++) {
        timeToReach[i] = (double)dist[i] / speed[i];
    }
    qsort(timeToReach, distSize, sizeof(double), compare);
    int count = 0;
    for (int i = 0; i < distSize; i++) {
        if (timeToReach[i] > (double)i) {
            count++;
        } else {
            break;
        }
    }
    return count;
}