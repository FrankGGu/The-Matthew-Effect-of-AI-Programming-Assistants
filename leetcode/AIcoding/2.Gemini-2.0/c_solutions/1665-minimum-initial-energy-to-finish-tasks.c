#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    return (y[1] - y[0]) - (x[1] - x[0]);
}

int minimumEffort(int** tasks, int tasksSize, int* tasksColSize){
    qsort(tasks, tasksSize, sizeof(tasks[0]), cmp);
    int energy = 0;
    int current = 0;
    for (int i = 0; i < tasksSize; i++) {
        if (current < tasks[i][1]) {
            energy += tasks[i][1] - current;
            current = tasks[i][1];
        }
        current -= tasks[i][0];
    }
    return energy;
}