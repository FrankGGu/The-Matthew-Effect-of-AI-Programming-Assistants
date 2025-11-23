#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int trainingPlan(int* actions, int actionsSize) {
    int x = 0, y = 0;
    for (int i = 0; i < actionsSize; i++) {
        x ^= actions[i];
        y |= actions[i];
    }
    return x & y;
}