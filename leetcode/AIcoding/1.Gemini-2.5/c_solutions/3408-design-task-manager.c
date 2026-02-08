#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

static inline int int_max(int a, int b) {
    return a > b ? a : b;
}

#define MAX_TASKS 100001

typedef struct {
    int original_duration;
    int added_time;
    bool is_completed;
} Task;

typedef struct {
    Task tasks[MAX_TASKS];
    bool task_exists[MAX_TASKS];
} TaskManager;

TaskManager* taskManagerCreate() {
    TaskManager* obj = (TaskManager*) malloc(sizeof(TaskManager));
    if (obj == NULL) return NULL;
    memset(obj->task_exists, 0, sizeof(obj->task_exists));
    return obj;
}

void taskManagerAddTask(TaskManager* obj, int taskId, int duration, int currentTime) {
    if (taskId < 1 || taskId >= MAX_TASKS) {
        return;
    }
    obj->tasks[taskId].original_duration = duration;
    obj->tasks[taskId].added_time = currentTime;
    obj->tasks[taskId].is_completed = false;
    obj->task_exists[taskId] = true;
}

void taskManagerCompleteTask(TaskManager* obj, int taskId, int currentTime) {
    if (taskId < 1 || taskId >= MAX_TASKS || !obj->task_exists[taskId]) {
        return;
    }
    if (obj->tasks[taskId].is_completed) {
        return;
    }

    obj->tasks[taskId].is_completed = true;
}

int taskManagerGetRemainingTime(TaskManager* obj, int taskId, int currentTime) {
    if (taskId < 1 || taskId >= MAX_TASKS || !obj->task_exists[taskId]) {
        return -1;
    }

    Task* task = &obj->tasks[taskId];

    if (task->is_completed) {
        return 0;
    }

    int time_elapsed_since_add = int_max(0, currentTime - task->added_time);
    int remaining = task->original_duration - time_elapsed_since_add;

    if (remaining <= 0) {
        task->is_completed = true;
        return 0;
    }

    return remaining;
}

void taskManagerFree(TaskManager* obj) {
    free(obj);
}