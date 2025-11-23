#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    int start_time;
} Task;

int compare(const void* a, const void* b) {
    Task* taskA = (Task*)a;
    Task* taskB = (Task*)b;
    return taskA->id - taskB->id;
}

int* exclusiveTime(int n, char** logs, int logsSize, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    memset(result, 0, n * sizeof(int));

    Task* tasks = (Task*)malloc(logsSize * sizeof(Task));
    int taskCount = 0;

    for (int i = 0; i < logsSize; i++) {
        char* log = logs[i];
        char* token = strtok(log, ":");
        int id = atoi(token);
        token = strtok(NULL, ":");
        int time = atoi(token);

        if (strcmp(token, "start") == 0) {
            tasks[taskCount].id = id;
            tasks[taskCount].start_time = time;
            taskCount++;
        } else {
            int duration = time - tasks[taskCount - 1].start_time + 1;
            result[tasks[taskCount - 1].id] += duration;
            taskCount--;
        }
    }

    *returnSize = n;
    return result;
}