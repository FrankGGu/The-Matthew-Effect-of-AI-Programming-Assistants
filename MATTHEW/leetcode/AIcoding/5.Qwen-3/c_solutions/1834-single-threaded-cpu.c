#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int timestamp;
    int duration;
} Task;

int compare(const void *a, const void *b) {
    Task *taskA = (Task *)a;
    Task *taskB = (Task *)b;
    if (taskA->timestamp != taskB->timestamp) {
        return taskA->timestamp - taskB->timestamp;
    }
    return taskA->duration - taskB->duration;
}

int* assignTasks(int** tasks, int tasksSize, int* tasksColSize, int* returnSize) {
    int* result = (int*)malloc(tasksSize * sizeof(int));
    *returnSize = 0;

    Task* taskList = (Task*)malloc(tasksSize * sizeof(Task));
    for (int i = 0; i < tasksSize; i++) {
        taskList[i].timestamp = tasks[i][0];
        taskList[i].duration = tasks[i][1];
    }

    qsort(taskList, tasksSize, sizeof(Task), compare);

    int time = 0;
    int index = 0;
    int count = 0;

    while (count < tasksSize) {
        while (index < tasksSize && taskList[index].timestamp <= time) {
            index++;
        }

        if (index == 0) {
            time = taskList[0].timestamp;
        }

        int minDuration = INT_MAX;
        int selected = -1;

        for (int i = 0; i < index; i++) {
            if (taskList[i].duration < minDuration) {
                minDuration = taskList[i].duration;
                selected = i;
            }
        }

        if (selected == -1) {
            time = taskList[index].timestamp;
            selected = index;
            index++;
        }

        result[*returnSize] = selected;
        (*returnSize)++;
        time += taskList[selected].duration;
        taskList[selected].duration = 0;
    }

    free(taskList);
    return result;
}