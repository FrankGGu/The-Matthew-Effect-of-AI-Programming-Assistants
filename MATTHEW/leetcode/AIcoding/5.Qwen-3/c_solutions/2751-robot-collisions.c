#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int position;
    int direction;
    int index;
} Robot;

int compare(const void *a, const void *b) {
    Robot *r1 = (Robot *)a;
    Robot *r2 = (Robot *)b;
    return r1->position - r2->position;
}

int* survivedRobotsHealths(int* positions, int positionsSize, int* directions, int directionsSize, int* healths, int healthsSize, int* returnSize) {
    Robot robots[positionsSize];
    for (int i = 0; i < positionsSize; i++) {
        robots[i].position = positions[i];
        robots[i].direction = directions[i];
        robots[i].index = i;
    }

    qsort(robots, positionsSize, sizeof(Robot), compare);

    int stack[positionsSize];
    int top = -1;

    for (int i = 0; i < positionsSize; i++) {
        int current = i;
        while (top >= 0 && robots[stack[top]].direction == 1 && robots[current].direction == 0) {
            int prev = stack[top];
            if (healths[prev] > healths[current]) {
                healths[prev]--;
                current = -1;
                break;
            } else if (healths[prev] == healths[current]) {
                healths[prev]--;
                healths[current]--;
                top--;
                current = -1;
                break;
            } else {
                healths[current]--;
                top--;
            }
        }
        if (current != -1) {
            stack[++top] = current;
        }
    }

    int count = 0;
    for (int i = 0; i < positionsSize; i++) {
        if (healths[i] > 0) count++;
    }

    *returnSize = count;
    int *result = (int *)malloc(count * sizeof(int));
    int idx = 0;
    for (int i = 0; i < positionsSize; i++) {
        if (healths[i] > 0) {
            result[idx++] = healths[i];
        }
    }

    return result;
}