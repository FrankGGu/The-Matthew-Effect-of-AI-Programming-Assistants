#include <stdlib.h> // For malloc, free, realloc

typedef struct {
    long long* arr;
    int capacity;
    int size;
} MinHeap;

MinHeap* createMinHeap(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->arr = (long long*)malloc(sizeof(long long) * capacity);
    heap->capacity = capacity;
    heap->size = 0;
    return heap;
}

void swap(long long* a, long long* b) {
    long long temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(MinHeap* heap, int index) {
    int parent = (index - 1) / 2;
    while (index > 0 && heap->arr[parent] > heap->arr[index]) {
        swap(&heap->arr[parent], &heap->arr[index]);
        index = parent;
        parent = (index - 1) / 2;
    }
}

void heapifyDown(MinHeap* heap, int index) {
    int smallest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < heap->size && heap->arr[left] < heap->arr[smallest]) {
        smallest = left;
    }
    if (right < heap->size && heap->arr[right] < heap->arr[smallest]) {
        smallest = right;
    }

    if (smallest != index) {
        swap(&heap->arr[index], &heap->arr[smallest]);
        heapifyDown(heap, smallest);
    }
}

void push(MinHeap* heap, long long val) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2;
        heap->arr = (long long*)realloc(heap->arr, sizeof(long long) * heap->capacity);
    }
    heap->arr[heap->size++] = val;
    heapifyUp(heap, heap->size - 1);
}

long long pop(MinHeap* heap) {
    long long root = heap->arr[0];
    heap->arr[0] = heap->arr[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return root;
}

int isEmpty(MinHeap* heap) {
    return heap->size == 0;
}

void freeMinHeap(MinHeap* heap) {
    free(heap->arr);
    free(heap);
}

long long magicTower(int* nums, int numsSize) {
    MinHeap* min_pq = createMinHeap(numsSize); 
    long long current_health = 1;
    long long final_health_sum = 1;

    for (int i = 0; i < numsSize; i++) {
        current_health += nums[i];
        final_health_sum += nums[i];

        if (nums[i] < 0) {
            push(min_pq, nums[i]);
        }

        while (current_health < 1) {
            if (isEmpty(min_pq)) {
                freeMinHeap(min_pq);
                return -1;
            }

            long long val_to_skip = pop(min_pq);

            // Check if skipping this room allows survival.
            // Health after undoing val_to_skip: `current_health - val_to_skip`.
            // Health after applying skip cost: `(current_health - val_to_skip) - 1`.
            // This new health must be at least 1 for survival.
            // So, `current_health - val_to_skip - 1 >= 1`
            // Which simplifies to `current_health - val_to_skip >= 2`.
            if (current_health - val_to_skip < 2) {
                freeMinHeap(min_pq);
                return -1;
            }

            current_health -= val_to_skip; 
            current_health -= 1;           

            final_health_sum -= (val_to_skip + 1); 
        }
    }

    if (final_health_sum < 1) {
        freeMinHeap(min_pq);
        return -1;
    }

    freeMinHeap(min_pq);
    return final_health_sum;
}