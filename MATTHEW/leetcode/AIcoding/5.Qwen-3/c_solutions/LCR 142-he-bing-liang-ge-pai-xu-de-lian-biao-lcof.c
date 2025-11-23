#include <stdio.h>
#include <stdlib.h>

int* trainingPlan(int* actions, int actionsSize, int* returnSize) {
    int* result = (int*)malloc(actionsSize * sizeof(int));
    *returnSize = 0;
    for (int i = 0; i < actionsSize; i++) {
        if (actions[i] % 2 == 1) {
            result[*returnSize] = actions[i];
            (*returnSize)++;
        }
    }
    for (int i = 0; i < actionsSize; i++) {
        if (actions[i] % 2 == 0) {
            result[*returnSize] = actions[i];
            (*returnSize)++;
        }
    }
    return result;
}