#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int *data;
    int size;
} Heap;

void swap(int *a, int *b) {
    int t = *a;
    *a = *b;
    *b = t;
}

void heapify_up(Heap *heap, int index) {
    while (index > 0) {
        int parent = (index - 1) / 2;
        if (heap->data[index] <= heap->data[parent]) break;
        swap(&heap->data[index], &heap->data[parent]);
        index = parent;
    }
}

void heapify_down(Heap *heap, int index) {
    int size = heap->size;
    while (true) {
        int left = 2 * index + 1;
        int right = 2 * index + 2;
        int largest = index;

        if (left < size && heap->data[left] > heap->data[largest]) largest = left;
        if (right < size && heap->data[right] > heap->data[largest]) largest = right;

        if (largest == index) break;
        swap(&heap->data[index], &heap->data[largest]);
        index = largest;
    }
}

Heap *create_heap(int capacity) {
    Heap *heap = (Heap *)malloc(sizeof(Heap));
    heap->data = (int *)malloc(capacity * sizeof(int));
    heap->size = 0;
    return heap;
}

void push(Heap *heap, int value) {
    if (heap->size == 0) {
        heap->data[0] = value;
        heap->size++;
        return;
    }
    if (heap->size >= (int)(sizeof(heap->data) / sizeof(heap->data[0]))) {
        heap->data = (int *)realloc(heap->data, (heap->size + 1) * sizeof(int));
    }
    heap->data[heap->size++] = value;
    heapify_up(heap, heap->size - 1);
}

int pop(Heap *heap) {
    if (heap->size == 0) return INT_MIN;
    int root = heap->data[0];
    heap->data[0] = heap->data[--heap->size];
    heapify_down(heap, 0);
    return root;
}

void free_heap(Heap *heap) {
    free(heap->data);
    free(heap);
}

int min(int a, int b) {
    return a < b ? a : b;
}

int minDeviation(int* nums, int numsSize) {
    int min_val = INT_MAX;
    Heap *max_heap = create_heap(numsSize);

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 != 0) {
            nums[i] *= 2;
        }
        min_val = min(min_val, nums[i]);
        push(max_heap, nums[i]);
    }

    int result = INT_MAX;

    while (true) {
        int current_max = pop(max_heap);
        result = min(result, current_max - min_val);

        if (current_max % 2 != 0) break;

        int new_val = current_max / 2;
        min_val = min(min_val, new_val);
        push(max_heap, new_val);

        if (max_heap->size == 0) break;
    }

    free_heap(max_heap);
    return result;
}