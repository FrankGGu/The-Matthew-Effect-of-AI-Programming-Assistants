#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* trainingPlan(int* actions, int actionsSize) {
    int xorSum = 0;
    for (int i = 0; i < actionsSize; i++) {
        xorSum ^= actions[i];
    }
    int* result = (int*)malloc(sizeof(int));
    *result = xorSum;
    return result;
}