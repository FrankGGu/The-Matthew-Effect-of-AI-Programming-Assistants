#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_TASKS 100

typedef struct {
    int taskId;
    int priority;
    char description[100];
} Task;

typedef struct {
    Task tasks[MAX_TASKS];
    int size;
} TaskManager;

TaskManager* createTaskManager() {
    TaskManager* tm = (TaskManager*)malloc(sizeof(TaskManager));
    tm->size = 0;
    return tm;
}

void addTask(TaskManager* tm, int taskId, int priority, const char* description) {
    if (tm->size < MAX_TASKS) {
        tm->tasks[tm->size].taskId = taskId;
        tm->tasks[tm->size].priority = priority;
        strncpy(tm->tasks[tm->size].description, description, 99);
        tm->tasks[tm->size].description[99] = '\0';
        tm->size++;
    }
}

Task* getNextTask(TaskManager* tm) {
    if (tm->size == 0) {
        return NULL;
    }

    int highestPriority = -1;
    int highestPriorityIndex = -1;

    for (int i = 0; i < tm->size; i++) {
        if (tm->tasks[i].priority > highestPriority) {
            highestPriority = tm->tasks[i].priority;
            highestPriorityIndex = i;
        }
    }

    if (highestPriorityIndex == -1) {
        return NULL;
    }

    Task* nextTask = (Task*)malloc(sizeof(Task));
    memcpy(nextTask, &tm->tasks[highestPriorityIndex], sizeof(Task));

    // Remove the task from the task manager
    for (int i = highestPriorityIndex; i < tm->size - 1; i++) {
        tm->tasks[i] = tm->tasks[i + 1];
    }
    tm->size--;

    return nextTask;
}

void completeTask(Task* task) {
    free(task);
}

void destroyTaskManager(TaskManager* tm) {
    free(tm);
}