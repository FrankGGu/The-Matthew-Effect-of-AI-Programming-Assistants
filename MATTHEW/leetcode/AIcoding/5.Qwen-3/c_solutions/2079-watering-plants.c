#include <stdio.h>
#include <stdlib.h>

int wateringPlants(int* plants, int plantsSize, int capacity) {
    int currentCapacity = capacity;
    int steps = 0;

    for (int i = 0; i < plantsSize; i++) {
        if (currentCapacity < plants[i]) {
            currentCapacity = capacity;
            steps += 2 * i;
        }
        steps++;
        currentCapacity -= plants[i];
    }

    return steps;
}