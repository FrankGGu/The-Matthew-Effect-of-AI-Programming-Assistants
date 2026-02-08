#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* trainingPlan(int* actions, int actionsSize, int k, int* returnSize) {
    int* result = (int*)malloc(actionsSize * sizeof(int));
    *returnSize = actionsSize;
    k %= actionsSize;
    if (k < 0) {
        k += actionsSize;
    }
    for (int i = 0; i < actionsSize; i++) {
        result[i] = actions[(i + actionsSize - k) % actionsSize];
    }
    return result;
}