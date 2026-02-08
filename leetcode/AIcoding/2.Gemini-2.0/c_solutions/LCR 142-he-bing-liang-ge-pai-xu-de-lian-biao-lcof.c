#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int trainingPlan(int* actions, int actionsSize) {
    int xor_sum = 0;
    for (int i = 0; i < actionsSize; i++) {
        xor_sum ^= actions[i];
    }
    return xor_sum;
}