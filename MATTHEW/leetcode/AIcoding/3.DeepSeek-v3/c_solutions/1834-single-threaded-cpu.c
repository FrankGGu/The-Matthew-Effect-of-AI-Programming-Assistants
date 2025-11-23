typedef struct {
    int index;
    int enqueueTime;
    int processingTime;
} Task;

typedef struct {
    Task* data;
    int size;
    int capacity;
} MinHeap;

MinHeap* createHeap(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->data = (Task*)malloc(sizeof(Task) * capacity);
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

void swap(Task* a, Task* b) {
    Task temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(MinHeap* heap, int idx) {
    while (idx > 0) {
        int parent = (idx - 1) / 2;
        if (heap->data[idx].processingTime < heap->data[parent].processingTime || 
           (heap->data[idx].processingTime == heap->data[parent].processingTime && 
            heap->data[idx].index < heap->data[parent].index)) {
            swap(&heap->data[idx], &heap->data[parent]);
            idx = parent;
        } else {
            break;
        }
    }
}

void heapifyDown(MinHeap* heap, int idx) {
    int left, right, smallest;
    while (idx < heap->size) {
        smallest = idx;
        left = 2 * idx + 1;
        right = 2 * idx + 2;

        if (left < heap->size && 
            (heap->data[left].processingTime < heap->data[smallest].processingTime ||
            (heap->data[left].processingTime == heap->data[smallest].processingTime && 
             heap->data[left].index < heap->data[smallest].index))) {
            smallest = left;
        }

        if (right < heap->size && 
            (heap->data[right].processingTime < heap->data[smallest].processingTime ||
            (heap->data[right].processingTime == heap->data[smallest].processingTime && 
             heap->data[right].index < heap->data[smallest].index))) {
            smallest = right;
        }

        if (smallest != idx) {
            swap(&heap->data[idx], &heap->data[smallest]);
            idx = smallest;
        } else {
            break;
        }
    }
}

void push(MinHeap* heap, Task task) {
    if (heap->size == heap->capacity) return;
    heap->data[heap->size] = task;
    heapifyUp(heap, heap->size);
    heap->size++;
}

Task pop(MinHeap* heap) {
    Task task = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return task;
}

int isEmpty(MinHeap* heap) {
    return heap->size == 0;
}

int compare(const void* a, const void* b) {
    Task* taskA = (Task*)a;
    Task* taskB = (Task*)b;
    if (taskA->enqueueTime != taskB->enqueueTime) {
        return taskA->enqueueTime - taskB->enqueueTime;
    }
    if (taskA->processingTime != taskB->processingTime) {
        return taskA->processingTime - taskB->processingTime;
    }
    return taskA->index - taskB->index;
}

int* getOrder(int** tasks, int tasksSize, int* tasksColSize, int* returnSize) {
    Task* taskArr = (Task*)malloc(sizeof(Task) * tasksSize);
    for (int i = 0; i < tasksSize; i++) {
        taskArr[i].index = i;
        taskArr[i].enqueueTime = tasks[i][0];
        taskArr[i].processingTime = tasks[i][1];
    }

    qsort(taskArr, tasksSize, sizeof(Task), compare);

    MinHeap* heap = createHeap(tasksSize);
    int* result = (int*)malloc(sizeof(int) * tasksSize);
    int resultIdx = 0;
    int taskIdx = 0;
    long long currentTime = 0;

    while (resultIdx < tasksSize) {
        if (isEmpty(heap) && taskIdx < tasksSize) {
            currentTime = (currentTime > taskArr[taskIdx].enqueueTime) ? currentTime : taskArr[taskIdx].enqueueTime;
        }

        while (taskIdx < tasksSize && taskArr[taskIdx].enqueueTime <= currentTime) {
            push(heap, taskArr[taskIdx]);
            taskIdx++;
        }

        if (!isEmpty(heap)) {
            Task currentTask = pop(heap);
            result[resultIdx++] = currentTask.index;
            currentTime += currentTask.processingTime;
        }
    }

    free(taskArr);
    free(heap->data);
    free(heap);

    *returnSize = tasksSize;
    return result;
}