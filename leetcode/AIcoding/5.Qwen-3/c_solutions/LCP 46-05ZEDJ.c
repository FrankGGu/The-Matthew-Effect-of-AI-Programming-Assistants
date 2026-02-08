#include <stdio.h>
#include <stdlib.h>

int* assignTasks(int* tasks, int tasksSize, int* workers, int workersSize, int** results, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * tasksSize);
    *returnSize = tasksSize;
    for (int i = 0; i < tasksSize; i++) {
        result[i] = -1;
    }
    int* taskIndices = (int*)malloc(sizeof(int) * tasksSize);
    for (int i = 0; i < tasksSize; i++) {
        taskIndices[i] = i;
    }
    for (int i = 0; i < tasksSize; i++) {
        for (int j = 0; j < tasksSize - 1; j++) {
            if (tasks[taskIndices[j]] > tasks[taskIndices[j + 1]]) {
                int temp = taskIndices[j];
                taskIndices[j] = taskIndices[j + 1];
                taskIndices[j + 1] = temp;
            }
        }
    }
    int* workerIndices = (int*)malloc(sizeof(int) * workersSize);
    for (int i = 0; i < workersSize; i++) {
        workerIndices[i] = i;
    }
    for (int i = 0; i < workersSize; i++) {
        for (int j = 0; j < workersSize - 1; j++) {
            if (workers[workerIndices[j]] > workers[workerIndices[j + 1]]) {
                int temp = workerIndices[j];
                workerIndices[j] = workerIndices[j + 1];
                workerIndices[j + 1] = temp;
            }
        }
    }
    int* taskCount = (int*)malloc(sizeof(int) * tasksSize);
    for (int i = 0; i < tasksSize; i++) {
        taskCount[i] = 0;
    }
    for (int i = 0; i < tasksSize; i++) {
        int taskId = taskIndices[i];
        int workerId = workerIndices[taskCount[taskId] % workersSize];
        result[taskId] = workerId;
        taskCount[taskId]++;
    }
    *results = result;
    return result;
}