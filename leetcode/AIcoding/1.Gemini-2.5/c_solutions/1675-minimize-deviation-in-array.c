#include <stdlib.h> // For malloc, free, realloc
#include <limits.h> // For INT_MAX

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

typedef struct {
    int* data;
    int capacity;
    int size;
} MaxHeap;

void maxHeapifyUp(MaxHeap* heap, int index) {
    int parent = (index - 1) / 2;
    while (index > 0 && heap->data[index] > heap->data[parent]) {
        swap(&heap->data[index], &heap->data[parent]);
        index = parent;
        parent = (index - 1) / 2;
    }
}

void maxHeapifyDown(MaxHeap* heap, int index) {
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
        maxHeapifyDown(heap, largest);
    }
}

void maxHeap_push(MaxHeap* heap, int value) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2;
        heap->data = (int*)realloc(heap->data, sizeof(int) * heap->capacity);
    }
    heap->data[heap->size] = value;
    heap->size++;
    maxHeapifyUp(heap, heap->size - 1);
}

int maxHeap_pop(MaxHeap* heap) {
    if (heap->size == 0) {
        return -1;
    }
    int root = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    maxHeapifyDown(heap, 0);
    return root;
}

int maxHeap_top(MaxHeap* heap) {
    if (heap->size == 0) {
        return -1;
    }
    return heap->data[0];
}

MaxHeap* createMaxHeap(int capacity) {
    MaxHeap* heap = (MaxHeap*)malloc(sizeof(MaxHeap));
    heap->data = (int*)malloc(sizeof(int) * capacity);
    heap->capacity = capacity;
    heap->size = 0;
    return heap;
}

void destroyMaxHeap(MaxHeap* heap) {
    free(heap->data);
    free(heap);
}

int minimizeDeviation(int* nums, int numsSize) {
    MaxHeap* max_pq = createMaxHeap(numsSize);
    int min_val = INT_MAX;

    for (int i = 0; i < numsSize; i++) {
        int current_num = nums[i];
        if (current_num % 2 == 1) {
            current_num *= 2;
        }
        maxHeap_push(max_pq, current_num);
        if (current_num < min_val) {
            min_val = current_num;
        }
    }

    int min_deviation = maxHeap_top(max_pq) - min_val;

    while (maxHeap_top(max_pq) % 2 == 0) {
        int current_max = maxHeap_pop(max_pq);

        current_max /= 2;

        maxHeap_push(max_pq, current_max);

        if (current_max < min_val) {
            min_val = current_max;
        }

        int current_deviation = maxHeap_top(max_pq) - min_val;
        if (current_deviation < min_deviation) {
            min_deviation = current_deviation;
        }
    }

    destroyMaxHeap(max_pq);

    return min_deviation;
}