#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    return (y[0] - x[0]) - (y[1] - x[1]);
}

int minInitialEnergy(int** tasks, int tasksSize, int* tasksColSize) {
    int i;
    int total = 0;
    qsort(tasks, tasksSize, sizeof(int*), compare);
    for (i = 0; i < tasksSize; i++) {
        total += tasks[i][0] - tasks[i][1];
    }
    return total + 1;
}