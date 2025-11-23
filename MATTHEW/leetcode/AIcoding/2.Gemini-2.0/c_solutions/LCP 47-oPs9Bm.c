#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool securityCheck(int capacity, int weight, int* weights, int weightsSize) {
    int currentWeight = 0;
    for (int i = 0; i < weightsSize; i++) {
        currentWeight += weights[i];
    }
    return currentWeight <= capacity;
}