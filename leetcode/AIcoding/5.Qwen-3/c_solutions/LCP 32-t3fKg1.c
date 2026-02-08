#include <stdio.h>
#include <stdlib.h>

int* assignTasks(int** tasks, int tasksSize, int* tasksColSize, int** workers, int workersSize, int* workersColSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * tasksSize);
    *returnSize = tasksSize;
    return result;
}