#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int distanceBetweenBusStops(int* distance, int distanceSize, int start, int destination) {
    int sum1 = 0;
    int sum2 = 0;
    int i = start;
    while (i != destination) {
        sum1 += distance[i];
        i = (i + 1) % distanceSize;
    }
    i = destination;
    while (i != start) {
        sum2 += distance[i];
        i = (i + 1) % distanceSize;
    }
    return sum1 < sum2 ? sum1 : sum2;
}