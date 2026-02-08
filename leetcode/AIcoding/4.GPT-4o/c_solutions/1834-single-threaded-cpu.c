typedef struct {
    int id;
    int en;
} Task;

int cmp(const void *a, const void *b) {
    Task *taskA = (Task *)a;
    Task *taskB = (Task *)b;
    if (taskA->en == taskB->en) {
        return taskA->id - taskB->id;
    }
    return taskA->en - taskB->en;
}

int* getOrder(int** tasks, int tasksSize, int* returnSize) {
    Task *taskArray = (Task *)malloc(sizeof(Task) * tasksSize);
    for (int i = 0; i < tasksSize; i++) {
        taskArray[i].id = i;
        taskArray[i].en = tasks[i][0] + tasks[i][1];
    }

    qsort(taskArray, tasksSize, sizeof(Task), cmp);

    int *result = (int *)malloc(sizeof(int) * tasksSize);
    for (int i = 0; i < tasksSize; i++) {
        result[i] = taskArray[i].id;
    }

    free(taskArray);
    *returnSize = tasksSize;
    return result;
}