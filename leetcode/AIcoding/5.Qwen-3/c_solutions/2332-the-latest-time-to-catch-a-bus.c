#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int latestTimeToCatchABus(int* buses, int busesSize, int* passengers, int passengersSize) {
    qsort(buses, busesSize, sizeof(int), compare);
    qsort(passengers, passengersSize, sizeof(int), compare);

    int i = 0, j = 0;
    int lastBus = buses[busesSize - 1];
    int lastPassenger = passengers[passengersSize - 1];

    while (i < busesSize && j < passengersSize) {
        if (passengers[j] > buses[i]) {
            i++;
        } else {
            j++;
        }
    }

    if (j == passengersSize) {
        return lastBus;
    }

    int prev = -1;
    for (i = 0; i < passengersSize; i++) {
        if (passengers[i] > lastBus) {
            break;
        }
        if (prev != -1 && passengers[i] != prev + 1) {
            return prev + 1;
        }
        prev = passengers[i];
    }

    return lastBus;
}