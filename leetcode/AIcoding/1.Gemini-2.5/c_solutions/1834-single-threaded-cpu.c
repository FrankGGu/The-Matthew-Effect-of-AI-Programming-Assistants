#include <stdlib.h> // For malloc, free, qsort

typedef struct {
    int original_index;
    int enqueue_time;
    int processing_time;
} Task;

int compareTasksForSort(const void* a, const void* b) {
    Task* taskA = (Task*)a;
    Task* taskB = (Task*)b;
    if (taskA->enqueue_time != taskB->enqueue_time) {
        return taskA->enqueue_time - taskB->enqueue_time;
    }
    return taskA->original_index - taskB->original_index;
}

int compareTasksForHeap(Task taskA, Task taskB) {
    if (taskA.processing_time != taskB.processing_time) {
        return taskA.processing_time - taskB.processing_time;
    }
    return taskA.original_index - taskB.original_index;
}

void heap_push(Task* pq, int* pq_size_ptr, Task task) {
    pq[(*pq_size_ptr)++] = task;
    int current = *pq_size_ptr - 1;
    while (current > 0) {
        int parent = (current - 1) / 2;
        if (compareTasksForHeap(pq[current], pq[parent]) < 0) {
            Task temp = pq[current];
            pq[current] = pq[parent];
            pq[parent] = temp;
            current = parent;
        } else {
            break;
        }
    }
}

Task heap_pop(Task* pq, int* pq_size_ptr) {
    Task root = pq[0];
    pq[0] = pq[--(*pq_size_ptr)];
    int current = 0;
    while (1) {
        int left_child = 2 * current + 1;
        int right_child = 2 * current + 2;
        int smallest = current;

        if (left_child < *pq_size_ptr && compareTasksForHeap(pq[left_child], pq[smallest]) < 0) {
            smallest = left_child;
        }
        if (right_child < *pq_size_ptr && compareTasksForHeap(pq[right_child], pq[smallest]) < 0) {
            smallest = right_child;
        }

        if (smallest != current) {
            Task temp = pq[current];
            pq[current] = pq[smallest];
            pq[smallest] = temp;
            current = smallest;
        } else {
            break;
        }
    }
    return root;
}

int* getOrder(int** tasks, int tasksSize, int* tasksColSize, int* returnSize) {
    // 1. Create and populate an array of Task structs with original indices
    Task* sorted_tasks = (Task*)malloc(tasksSize * sizeof(Task));
    for (int i = 0; i < tasksSize; i++) {
        sorted_tasks[i].original_index = i;
        sorted_tasks[i].enqueue_time = tasks[i][0];
        sorted_tasks[i].processing_time = tasks[i][1];
    }

    // 2. Sort tasks by enqueue_time (and original_index for tie-breaking)
    qsort(sorted_tasks, tasksSize, sizeof(Task), compareTasksForSort);

    // 3. Initialize priority queue (min-heap)
    Task* pq = (Task*)malloc(tasksSize * sizeof(Task));
    int pq_size = 0;

    // 4. Initialize simulation variables
    long long current_time = 0; // Use long long for current_time to prevent overflow
    int task_ptr = 0;           // Pointer to the next task in sorted_tasks to consider adding to PQ

    int* result = (int*)malloc(tasksSize * sizeof(int));
    *returnSize = tasksSize;
    int result_idx = 0;

    // 5. Simulate CPU processing
    while (result_idx < tasksSize) {
        // If the CPU is idle and there are still tasks to be enqueued,
        // advance current_time to the enqueue_time of the next task.
        if (pq_size == 0 && task_ptr < tasksSize) {
            current_time = (long long)sorted_tasks[task_ptr].enqueue_time;
        }

        // Add all tasks whose enqueue_time is <= current_time to the PQ
        while (task_ptr < tasksSize && sorted_tasks[task_ptr].enqueue_time <= current_time) {
            heap_push(pq, &pq_size, sorted_tasks[task_ptr]);
            task_ptr++;
        }

        // Process a task from the priority queue if available
        if (pq_size > 0) {
            Task picked_task = heap_pop(pq, &pq_size);
            result[result_idx++] = picked_task.original_index;
            current_time += picked_task.processing_time;
        }
    }

    // Free allocated memory
    free(sorted_tasks);
    free(pq);

    return result;
}