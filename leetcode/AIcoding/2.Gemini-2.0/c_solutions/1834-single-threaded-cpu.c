#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    int enqueueTime;
    int processingTime;
} Task;

typedef struct {
    Task* tasks;
    int size;
    int capacity;
} Heap;

Heap* createHeap(int capacity) {
    Heap* heap = (Heap*)malloc(sizeof(Heap));
    heap->tasks = (Task*)malloc(capacity * sizeof(Task));
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

void swap(Task* a, Task* b) {
    Task temp = *a;
    *a = *b;
    *b = &temp;
}

void heapify(Heap* heap, int i) {
    int smallest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < heap->size && (heap->tasks[left].processingTime < heap->tasks[smallest].processingTime || (heap->tasks[left].processingTime == heap->tasks[smallest].processingTime && heap->tasks[left].id < heap->tasks[smallest].id))) {
        smallest = left;
    }

    if (right < heap->size && (heap->tasks[right].processingTime < heap->tasks[smallest].processingTime || (heap->tasks[right].processingTime == heap->tasks[smallest].processingTime && heap->tasks[right].id < heap->tasks[smallest].id))) {
        smallest = right;
    }

    if (smallest != i) {
        Task temp = heap->tasks[i];
        heap->tasks[i] = heap->tasks[smallest];
        heap->tasks[smallest] = temp;
        heapify(heap, smallest);
    }
}

void insert(Heap* heap, Task task) {
    if (heap->size == heap->capacity) return;
    heap->tasks[heap->size] = task;
    int i = heap->size;
    heap->size++;

    while (i > 0 && (heap->tasks[(i - 1) / 2].processingTime > heap->tasks[i].processingTime || (heap->tasks[(i - 1) / 2].processingTime == heap->tasks[i].processingTime && heap->tasks[(i - 1) / 2].id > heap->tasks[i].id))) {
        Task temp = heap->tasks[i];
        heap->tasks[i] = heap->tasks[(i - 1) / 2];
        heap->tasks[(i - 1) / 2] = temp;
        i = (i - 1) / 2;
    }
}

Task extractMin(Heap* heap) {
    if (heap->size <= 0) {
        Task emptyTask = {-1, -1, -1};
        return emptyTask;
    }

    if (heap->size == 1) {
        heap->size = 0;
        return heap->tasks[0];
    }

    Task root = heap->tasks[0];
    heap->tasks[0] = heap->tasks[heap->size - 1];
    heap->size--;
    heapify(heap, 0);

    return root;
}

int* singleThreadedCPU(int** tasks, int tasksSize, int* tasksColSize, int* returnSize) {
    Task* allTasks = (Task*)malloc(tasksSize * sizeof(Task));
    for (int i = 0; i < tasksSize; i++) {
        allTasks[i].id = i;
        allTasks[i].enqueueTime = tasks[i][0];
        allTasks[i].processingTime = tasks[i][1];
    }

    // Sort tasks by enqueue time
    qsort(allTasks, tasksSize, sizeof(Task), [](const void* a, const void* b) {
        return ((Task*)a)->enqueueTime - ((Task*)b)->enqueueTime;
    });

    int* result = (int*)malloc(tasksSize * sizeof(int));
    *returnSize = 0;

    Heap* availableTasks = createHeap(tasksSize);
    long long currentTime = 0;
    int taskIndex = 0;

    while (*returnSize < tasksSize) {
        while (taskIndex < tasksSize && allTasks[taskIndex].enqueueTime <= currentTime) {
            insert(availableTasks, allTasks[taskIndex]);
            taskIndex++;
        }

        if (availableTasks->size == 0) {
            if (taskIndex < tasksSize) {
                currentTime = allTasks[taskIndex].enqueueTime;
            } else {
                break;
            }
        } else {
            Task nextTask = extractMin(availableTasks);
            result[(*returnSize)++] = nextTask.id;
            currentTime += nextTask.processingTime;
        }
    }

    free(availableTasks->tasks);
    free(availableTasks);
    free(allTasks);

    return result;
}