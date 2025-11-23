#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    return x[1] - y[1];
}

bool carPooling(int** trips, int tripsSize, int* tripsColSize, int capacity) {
    int *diff = (int *)calloc(1001, sizeof(int));
    for (int i = 0; i < tripsSize; i++) {
        int start = trips[i][1];
        int end = trips[i][2];
        int passengers = trips[i][0];
        diff[start] += passengers;
        diff[end] -= passengers;
    }

    int currentPassengers = 0;
    for (int i = 0; i <= 1000; i++) {
        currentPassengers += diff[i];
        if (currentPassengers > capacity) {
            free(diff);
            return false;
        }
    }

    free(diff);
    return true;
}