#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int wateringPlants(int* plants, int plantsSize, int capacityA, int capacityB) {
    int steps = 0;
    int waterA = capacityA;
    int waterB = capacityB;
    int i = 0;
    int j = plantsSize - 1;

    while (i < j) {
        if (waterA >= plants[i]) {
            waterA -= plants[i];
            steps++;
            i++;
        } else {
            waterA = capacityA;
            steps++;
            waterA -= plants[i];
            i++;
        }

        if (waterB >= plants[j]) {
            waterB -= plants[j];
            steps++;
            j--;
        } else {
            waterB = capacityB;
            steps++;
            waterB -= plants[j];
            j--;
        }
    }

    if (i == j) {
        if (waterA >= waterB) {
            if (waterA >= plants[i]) {
                steps++;
            } else {
                steps++;
            }
        } else {
            if (waterB >= plants[i]) {
                steps++;
            } else {
                steps++;
            }
        }
    }

    return steps;
}