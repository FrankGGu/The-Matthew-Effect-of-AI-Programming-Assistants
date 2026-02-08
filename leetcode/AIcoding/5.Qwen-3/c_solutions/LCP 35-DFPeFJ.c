#include <stdio.h>
#include <stdlib.h>

int carPooling(int** trips, int tripsSize, int* tripsColSize, int capacity) {
    int* delta = (int*)calloc(1001, sizeof(int));
    for (int i = 0; i < tripsSize; i++) {
        int start = trips[i][1];
        int end = trips[i][2];
        int num = trips[i][0];
        delta[start] += num;
        delta[end] -= num;
    }

    int current = 0;
    for (int i = 0; i <= 1000; i++) {
        current += delta[i];
        if (current > capacity) {
            free(delta);
            return 0;
        }
    }

    free(delta);
    return 1;
}