#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int task_id;
    int priority;
    int timestamp;
} Task;

typedef struct {
    Task* tasks;
    int size;
    int capacity;
} TaskManager;

TaskManager* taskManagerCreate() {
    TaskManager* manager = (TaskManager*)malloc(sizeof(TaskManager));
    manager->tasks = NULL;
    manager->size = 0;
    manager->capacity = 0;
    return manager;
}

void taskManagerAddTask(TaskManager* obj, int task_id, int priority, int timestamp) {
    if (obj->size == obj->capacity) {
        obj->capacity = (obj->capacity == 0) ? 1 : obj->capacity * 2;
        obj->tasks = (Task*)realloc(obj->tasks, obj->capacity * sizeof(Task));
    }
    obj->tasks[obj->size].task_id = task_id;
    obj->tasks[obj->size].priority = priority;
    obj->tasks[obj->size].timestamp = timestamp;
    obj->size++;
}

int taskManagerGetNextTask(TaskManager* obj) {
    if (obj->size == 0) return -1;

    int min_priority = obj->tasks[0].priority;
    int min_timestamp = obj->tasks[0].timestamp;
    int min_index = 0;

    for (int i = 1; i < obj->size; i++) {
        if (obj->tasks[i].priority < min_priority ||
            (obj->tasks[i].priority == min_priority && obj->tasks[i].timestamp < min_timestamp)) {
            min_priority = obj->tasks[i].priority;
            min_timestamp = obj->tasks[i].timestamp;
            min_index = i;
        }
    }

    int task_id = obj->tasks[min_index].task_id;

    for (int i = min_index; i < obj->size - 1; i++) {
        obj->tasks[i] = obj->tasks[i + 1];
    }
    obj->size--;

    return task_id;
}

void taskManagerFree(TaskManager* obj) {
    free(obj->tasks);
    free(obj);
}