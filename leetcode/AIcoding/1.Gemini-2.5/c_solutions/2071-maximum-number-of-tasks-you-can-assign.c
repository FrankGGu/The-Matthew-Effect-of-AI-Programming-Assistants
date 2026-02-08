#include <stdlib.h> // For qsort, malloc, free
#include <stdbool.h> // For bool

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

typedef struct {
    int* data;
    int size;
    int capacity;
} MaxHeap;

void initMaxHeap(MaxHeap* heap, int capacity) {
    heap->data = (int*)malloc(sizeof(int) * capacity);
    heap->size = 0;
    heap->capacity = capacity;
}

void freeMaxHeap(MaxHeap* heap) {
    free(heap->data);
}

void heapifyUp(MaxHeap* heap, int idx) {
    int parent = (idx - 1) / 2;
    while (idx > 0 && heap->data[idx] > heap->data[parent]) {
        int temp = heap->data[idx];
        heap->data[idx] = heap->data[parent];
        heap->data[parent] = temp;
        idx = parent;
        parent = (idx - 1) / 2;
    }
}

void heapifyDown(MaxHeap* heap, int idx) {
    int leftChild = 2 * idx + 1;
    int rightChild = 2 * idx + 2;
    int largest = idx;

    if (leftChild < heap->size && heap->data[leftChild] > heap->data[largest]) {
        largest = leftChild;
    }
    if (rightChild < heap->size && heap->data[rightChild] > heap->data[largest]) {
        largest = rightChild;
    }

    if (largest != idx) {
        int temp = heap->data[idx];
        heap->data[idx] = heap->data[largest];
        heap->data[largest] = temp;
        heapifyDown(heap, largest);
    }
}

void pushMaxHeap(MaxHeap* heap, int val) {
    if (heap->size == heap->capacity) {
        // This case should ideally not be hit if capacity is chosen correctly (workersSize)
        return;
    }
    heap->data[heap->size] = val;
    heap->size++;
    heapifyUp(heap, heap->size - 1);
}

int popMaxHeap(MaxHeap* heap) {
    if (heap->size == 0) {
        return -1; // Sentinel for error or empty heap
    }
    int val = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return val;
}

int peekMaxHeap(MaxHeap* heap) {
    if (heap->size == 0) {
        return -1; // Sentinel for error or empty heap
    }
    return heap->data[0];
}

bool isMaxHeapEmpty(MaxHeap* heap) {
    return heap->size == 0;
}

bool canAssign(int k, int* tasks, int tasksSize, int* workers, int workersSize, int pills, int strength) {
    if (k == 0) return true;
    if (k > tasksSize || k > workersSize) return false;

    MaxHeap pq;
    initMaxHeap(&pq, workersSize);

    int worker_ptr = 0; // Pointer for iterating through sorted workers
    int pills_left = pills;

    // Iterate through the 'k' easiest tasks (from tasks[0] to tasks[k-1])
    for (int i = 0; i < k; ++i) {
        // Add all workers who are strong enough for the current task (tasks[i]) with a pill
        // to the priority queue. These workers are considered from weakest to strongest.
        while (worker_ptr < workersSize && workers[worker_ptr] + strength >= tasks[i]) {
            pushMaxHeap(&pq, workers[worker_ptr]);
            worker_ptr++;
        }

        if (isMaxHeapEmpty(&pq)) {
            // No worker can do this task, even with a pill
            freeMaxHeap(&pq);
            return false;
        }

        // The strongest worker currently in the priority queue (pq.top())
        // is the best candidate to complete the current task.
        if (peekMaxHeap(&pq) >= tasks[i]) {
            // This strongest worker can do the task without a pill. Use them.
            popMaxHeap(&pq);
        } else {
            // No worker in pq can do tasks[i] without a pill. Must use a pill.
            if (pills_left > 0) {
                pills_left--;
                popMaxHeap(&pq); // Use the strongest worker with a pill
            } else {
                // No pills left, and no worker can do it without a pill
                freeMaxHeap(&pq);
                return false;
            }
        }
    }
    freeMaxHeap(&pq);
    return true;
}

int maxTaskAssign(int* tasks, int tasksSize, int* workers, int workersSize, int pills, int strength) {
    // Sort tasks and workers in ascending order
    qsort(tasks, tasksSize, sizeof(int), compare);
    qsort(workers, workersSize, sizeof(int), compare);

    int low = 0;
    int high = (tasksSize < workersSize) ? tasksSize : workersSize; // Max possible tasks to assign
    int ans = 0;

    // Binary search for the maximum number of tasks 'k'
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (canAssign(mid, tasks, tasksSize, workers, workersSize, pills, strength)) {
            ans = mid;
            low = mid + 1; // Try to assign more tasks
        } else {
            high = mid - 1; // Need to assign fewer tasks
        }
    }

    return ans;
}