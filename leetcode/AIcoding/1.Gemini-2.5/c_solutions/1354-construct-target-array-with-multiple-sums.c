#include <stdbool.h>
#include <stdlib.h>

typedef struct {
    long long *data;
    int capacity;
    int size;
} MaxHeap;

void swap(long long *a, long long *b) {
    long long temp = *a;
    *a = *b;
    *b = temp;
}

void heapify_up(MaxHeap *heap, int index) {
    int parent = (index - 1) / 2;
    while (index > 0 && heap->data[index] > heap->data[parent]) {
        swap(&heap->data[index], &heap->data[parent]);
        index = parent;
        parent = (index - 1) / 2;
    }
}

void heapify_down(MaxHeap *heap, int index) {
    int largest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < heap->size && heap->data[left] > heap->data[largest]) {
        largest = left;
    }
    if (right < heap->size && heap->data[right] > heap->data[largest]) {
        largest = right;
    }

    if (largest != index) {
        swap(&heap->data[index], &heap->data[largest]);
        heapify_down(heap, largest);
    }
}

MaxHeap* createMaxHeap(int capacity) {
    MaxHeap *heap = (MaxHeap*)malloc(sizeof(MaxHeap));
    heap->data = (long long*)malloc(sizeof(long long) * capacity);
    heap->capacity = capacity;
    heap->size = 0;
    return heap;
}

void destroyMaxHeap(MaxHeap *heap) {
    free(heap->data);
    free(heap);
}

void push(MaxHeap *heap, long long val) {
    heap->data[heap->size] = val;
    heapify_up(heap, heap->size);
    heap->size++;
}

long long pop(MaxHeap *heap) {
    long long max_val = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    if (heap->size > 0) {
        heapify_down(heap, 0);
    }
    return max_val;
}

long long peek(MaxHeap *heap) {
    return heap->data[0];
}

bool isPossible(int* target, int targetSize) {
    if (targetSize == 1) {
        return target[0] == 1;
    }

    MaxHeap *heap = createMaxHeap(targetSize);
    long long current_sum = 0;

    for (int i = 0; i < targetSize; i++) {
        push(heap, target[i]);
        current_sum += target[i];
    }

    while (peek(heap) != 1) {
        long long max_val = pop(heap);

        long long sum_of_others = current_sum - max_val;

        if (sum_of_others == 0) { 
            destroyMaxHeap(heap);
            return false;
        }

        if (max_val <= sum_of_others) {
            destroyMaxHeap(heap);
            return false;
        }

        long long new_val = max_val % sum_of_others;

        if (new_val == 0) {
            new_val = sum_of_others;
        }

        current_sum = sum_of_others + new_val;
        push(heap, new_val);
    }

    destroyMaxHeap(heap);
    return true;
}