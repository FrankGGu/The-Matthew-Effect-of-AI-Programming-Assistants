#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int capital;
    int profit;
} Project;

int compareProjects(const void* a, const void* b) {
    return ((Project*)a)->capital - ((Project*)b)->capital;
}

typedef struct {
    int* data;
    int capacity;
    int size;
} MaxHeap;

void heap_init(MaxHeap* heap, int capacity) {
    heap->data = (int*)malloc(sizeof(int) * capacity);
    heap->capacity = capacity;
    heap->size = 0;
}

void heap_free(MaxHeap* heap) {
    free(heap->data);
    heap->data = NULL;
    heap->capacity = 0;
    heap->size = 0;
}

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void heapify_up(MaxHeap* heap, int index) {
    int parent_idx = (index - 1) / 2;
    while (index > 0 && heap->data[index] > heap->data[parent_idx]) {
        swap(&heap->data[index], &heap->data[parent_idx]);
        index = parent_idx;
        parent_idx = (index - 1) / 2;
    }
}

void heapify_down(MaxHeap* heap, int index) {
    int largest = index;
    int left_child = 2 * index + 1;
    int right_child = 2 * index + 2;

    if (left_child < heap->size && heap->data[left_child] > heap->data[largest]) {
        largest = left_child;
    }
    if (right_child < heap->size && heap->data[right_child] > heap->data[largest]) {
        largest = right_child;
    }

    if (largest != index) {
        swap(&heap->data[index], &heap->data[largest]);
        heapify_down(heap, largest);
    }
}

void heap_push(MaxHeap* heap, int val) {
    if (heap->size == heap->capacity) {
        return; 
    }
    heap->data[heap->size] = val;
    heap->size++;
    heapify_up(heap, heap->size - 1);
}

int heap_pop(MaxHeap* heap) {
    if (heap->size == 0) {
        return -1; 
    }
    int max_val = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapify_down(heap, 0);
    return max_val;
}

bool heap_empty(MaxHeap* heap) {
    return heap->size == 0;
}

long long findMaximizedCapital(int k, int w, int* profits, int profitsSize, int* capital, int capitalSize) {
    Project* projects = (Project*)malloc(sizeof(Project) * profitsSize);
    for (int i = 0; i < profitsSize; ++i) {
        projects[i].capital = capital[i];
        projects[i].profit = profits[i];
    }

    qsort(projects, profitsSize, sizeof(Project), compareProjects);

    MaxHeap max_heap;
    heap_init(&max_heap, profitsSize);

    int project_idx = 0;
    long long current_w = w;

    for (int i = 0; i < k; ++i) {
        while (project_idx < profitsSize && projects[project_idx].capital <= current_w) {
            heap_push(&max_heap, projects[project_idx].profit);
            project_idx++;
        }

        if (heap_empty(&max_heap)) {
            break;
        }

        current_w += heap_pop(&max_heap);
    }

    free(projects);
    heap_free(&max_heap);

    return current_w;
}