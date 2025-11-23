#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int wateringPlants(int* plants, int plantsSize, int capacity) {
    int steps = 0;
    int currentCapacity = capacity;
    for (int i = 0; i < plantsSize; i++) {
        if (currentCapacity >= plants[i]) {
            steps++;
            currentCapacity -= plants[i];
        } else {
            steps += (i * 2);
            currentCapacity = capacity;
            steps++;
            currentCapacity -= plants[i];
        }
    }
    return steps;
}