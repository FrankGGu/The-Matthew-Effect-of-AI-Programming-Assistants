#include <stdio.h>
#include <stdlib.h>

int totalDistance(int** trips, int tripsSize, int* tripsColSize) {
    int max = 0;
    for (int i = 0; i < tripsSize; i++) {
        if (trips[i][2] > max) {
            max = trips[i][2];
        }
    }

    int* distance = (int*)calloc(max + 1, sizeof(int));
    for (int i = 0; i < tripsSize; i++) {
        int start = trips[i][1];
        int end = trips[i][2];
        int passengers = trips[i][0];
        for (int j = start; j < end; j++) {
            distance[j] += passengers;
        }
    }

    int total = 0;
    for (int i = 0; i <= max; i++) {
        total += distance[i];
    }

    free(distance);
    return total;
}