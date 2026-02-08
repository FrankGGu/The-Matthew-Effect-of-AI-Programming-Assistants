typedef struct {
    int* tasks;
    int* tags;
    int size;
    int capacity;
} TaskManager;

TaskManager* taskManagerCreate() {
    TaskManager* obj = (TaskManager*)malloc(sizeof(TaskManager));
    obj->capacity = 1000;
    obj->size = 0;
    obj->tasks = (int*)malloc(obj->capacity * sizeof(int));
    obj->tags = (int*)malloc(obj->capacity * sizeof(int));
    return obj;
}

void taskManagerAdd(TaskManager* obj, int taskID, int tag) {
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->tasks = (int*)realloc(obj->tasks, obj->capacity * sizeof(int));
        obj->tags = (int*)realloc(obj->tags, obj->capacity * sizeof(int));
    }
    obj->tasks[obj->size] = taskID;
    obj->tags[obj->size] = tag;
    obj->size++;
}

void taskManagerRemove(TaskManager* obj, int taskID) {
    for (int i = 0; i < obj->size; i++) {
        if (obj->tasks[i] == taskID) {
            for (int j = i; j < obj->size - 1; j++) {
                obj->tasks[j] = obj->tasks[j + 1];
                obj->tags[j] = obj->tags[j + 1];
            }
            obj->size--;
            break;
        }
    }
}

int* taskManagerFindTasks(TaskManager* obj, int tag, int* retSize) {
    int* result = (int*)malloc(obj->size * sizeof(int));
    int count = 0;
    for (int i = 0; i < obj->size; i++) {
        if (obj->tags[i] == tag) {
            result[count++] = obj->tasks[i];
        }
    }
    *retSize = count;
    return result;
}

void taskManagerFree(TaskManager* obj) {
    free(obj->tasks);
    free(obj->tags);
    free(obj);
}

/**
 * Your TaskManager struct will be instantiated and called as such:
 * TaskManager* obj = taskManagerCreate();
 * taskManagerAdd(obj, taskID, tag);
 * taskManagerRemove(obj, taskID);
 * int* param_3 = taskManagerFindTasks(obj, tag, retSize);
 * taskManagerFree(obj);
*/