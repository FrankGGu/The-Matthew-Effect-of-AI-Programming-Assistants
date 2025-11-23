#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    if (x[1] != y[1]) return y[1] - x[1];
    return x[0] - y[0];
}

int* hardestWorker(int** tasks, int tasksSize, int* tasksColSize, int* returnSize) {
    int *result = (int *)malloc(2 * sizeof(int));
    *returnSize = 2;

    int **employees = (int **)malloc(tasksSize * sizeof(int *));
    for (int i = 0; i < tasksSize; i++) {
        employees[i] = (int *)malloc(2 * sizeof(int));
        employees[i][0] = tasks[i][0];
        employees[i][1] = tasks[i][1] - (i > 0 ? tasks[i-1][1] : 0);
    }

    qsort(employees, tasksSize, sizeof(int *), compare);

    result[0] = employees[0][0];
    result[1] = employees[0][1];

    for (int i = 0; i < tasksSize; i++) {
        free(employees[i]);
    }
    free(employees);

    return result;
}