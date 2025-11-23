#include <stdlib.h>
#include <limits.h>

typedef struct {
    int* data;
    int size;
    int capacity;
} MaxHeap;

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

MaxHeap* createMaxHeap(int capacity) {
    MaxHeap* heap = (MaxHeap*)malloc(sizeof(MaxHeap));
    heap->data = (int*)malloc(capacity * sizeof(int));
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

void heapifyUp(MaxHeap* heap, int idx) {
    while (idx > 0) {
        int parent = (idx - 1) / 2;
        if (heap->data[parent] >= heap->data[idx]) break;
        swap(&heap->data[parent], &heap->data[idx]);
        idx = parent;
    }
}

void heapifyDown(MaxHeap* heap, int idx) {
    while (1) {
        int left = 2 * idx + 1;
        int right = 2 * idx + 2;
        int largest = idx;

        if (left < heap->size && heap->data[left] > heap->data[largest]) {
            largest = left;
        }
        if (right < heap->size && heap->data[right] > heap->data[largest]) {
            largest = right;
        }
        if (largest == idx) break;

        swap(&heap->data[idx], &heap->data[largest]);
        idx = largest;
    }
}

void push(MaxHeap* heap, int value) {
    if (heap->size == heap->capacity) return;
    heap->data[heap->size] = value;
    heapifyUp(heap, heap->size);
    heap->size++;
}

int pop(MaxHeap* heap) {
    if (heap->size == 0) return -1;
    int max = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return max;
}

int top(MaxHeap* heap) {
    if (heap->size == 0) return -1;
    return heap->data[0];
}

int minimumDeviation(int* nums, int numsSize) {
    MaxHeap* heap = createMaxHeap(numsSize * 2);
    int min_val = INT_MAX;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 1) {
            nums[i] *= 2;
        }
        push(heap, nums[i]);
        if (nums[i] < min_val) {
            min_val = nums[i];
        }
    }

    int min_deviation = INT_MAX;

    while (1) {
        int max_val = pop(heap);
        int current_deviation = max_val - min_val;
        if (current_deviation < min_deviation) {
            min_deviation = current_deviation;
        }

        if (max_val % 2 == 1) {
            break;
        }

        max_val /= 2;
        if (max_val < min_val) {
            min_val = max_val;
        }
        push(heap, max_val);
    }

    free(heap->data);
    free(heap);

    return min_deviation;
}