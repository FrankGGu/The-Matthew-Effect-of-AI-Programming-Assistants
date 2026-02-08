typedef struct {
    int id;
    int time;
} Task;

typedef struct {
    Task *tasks;
    int size;
    int capacity;
} TaskManager;

TaskManager* createTaskManager() {
    TaskManager *manager = (TaskManager *)malloc(sizeof(TaskManager));
    manager->size = 0;
    manager->capacity = 10;
    manager->tasks = (Task *)malloc(manager->capacity * sizeof(Task));
    return manager;
}

void addTask(TaskManager* obj, int taskId, int time) {
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->tasks = (Task *)realloc(obj->tasks, obj->capacity * sizeof(Task));
    }
    obj->tasks[obj->size].id = taskId;
    obj->tasks[obj->size].time = time;
    obj->size++;
}

int completeTask(TaskManager* obj) {
    if (obj->size == 0) return -1;
    int completedTaskId = obj->tasks[0].id;
    for (int i = 1; i < obj->size; i++) {
        obj->tasks[i-1] = obj->tasks[i];
    }
    obj->size--;
    return completedTaskId;
}

void freeTaskManager(TaskManager* obj) {
    free(obj->tasks);
    free(obj);
}