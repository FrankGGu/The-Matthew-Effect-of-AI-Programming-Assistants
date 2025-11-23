#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int latestTimeCatchTheBus(int* buses, int busesSize, int* passengers, int passengersSize, int capacity) {
    qsort(buses, busesSize, sizeof(int), compare);
    qsort(passengers, passengersSize, sizeof(int), compare);

    int passengerIndex = 0;
    int lastBusTime = 0;
    for (int i = 0; i < busesSize; i++) {
        int currentCapacity = 0;
        while (passengerIndex < passengersSize && passengers[passengerIndex] <= buses[i] && currentCapacity < capacity) {
            passengerIndex++;
            currentCapacity++;
        }
        lastBusTime = buses[i];
    }

    passengerIndex--;
    int result = lastBusTime;
    if (passengerIndex < 0) {
        return lastBusTime;
    }

    while (passengerIndex >= 0 && result == passengers[passengerIndex]) {
        result--;
        passengerIndex--;
    }

    return result;
}