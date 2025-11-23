#include <stdio.h>
#include <stdlib.h>

int distanceBetweenBusStops(int* stations, int stationsSize, int start, int end) {
    if (start == end) return 0;

    int total = 0;
    for (int i = 0; i < stationsSize; i++) {
        total += stations[i];
    }

    int clockwise = 0;
    if (start < end) {
        for (int i = start; i < end; i++) {
            clockwise += stations[i];
        }
    } else {
        for (int i = start; i < stationsSize; i++) {
            clockwise += stations[i];
        }
        for (int i = 0; i < end; i++) {
            clockwise += stations[i];
        }
    }

    int counterClockwise = total - clockwise;
    return (clockwise < counterClockwise) ? clockwise : counterClockwise;
}