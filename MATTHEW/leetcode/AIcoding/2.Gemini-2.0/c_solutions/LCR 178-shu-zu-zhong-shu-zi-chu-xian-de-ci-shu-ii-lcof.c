#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int trainingPlan(int* actions, int actionsSize, int k) {
    int count = 0;
    for (int i = 0; i < actionsSize; i++) {
        if (actions[i] == 1) {
            count++;
        }
    }
    if (k <= count) {
        return 1;
    } else {
        return 0;
    }
}