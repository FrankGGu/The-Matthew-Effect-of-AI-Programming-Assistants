#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool carPooling(int trips[][3], int tripsSize, int tripsColSize, int capacity) {
    int stops[1001] = {0};
    int max_stop = 0;

    for (int i = 0; i < tripsSize; i++) {
        stops[trips[i][1]] += trips[i][0];
        stops[trips[i][2]] -= trips[i][0];
        if (trips[i][2] > max_stop) {
            max_stop = trips[i][2];
        }
    }

    int current_passengers = 0;
    for (int i = 0; i <= max_stop; i++) {
        current_passengers += stops[i];
        if (current_passengers > capacity) {
            return false;
        }
    }

    return true;
}