#include <stdlib.h> // For malloc, free
#include <stdbool.h> // For bool

typedef struct {
    long long *data;
    int capacity;
    int size;
} MinHeap;

MinHeap* createMinHeap(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->data = (long long*)malloc(sizeof(long long) * capacity);
    heap->capacity = capacity;
    heap->size = 0;
    return heap;
}

void swap(long long *a, long long *b) {
    long long temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(MinHeap* heap, int index) {
    int parent = (index - 1) / 2;
    while (index > 0 && heap->data[index] < heap->data[parent]) {
        swap(&heap->data[index], &heap->data[parent]);
        index = parent;
        parent = (index - 1) / 2;
    }
}

void heapifyDown(MinHeap* heap, int index) {
    int smallest = index;
    int leftChild = 2 * index + 1;
    int rightChild = 2 * index + 2;

    if (leftChild < heap->size && heap->data[leftChild] < heap->data[smallest]) {
        smallest = leftChild;
    }
    if (rightChild < heap->size && heap->data[rightChild] < heap->data[smallest]) {
        smallest = rightChild;
    }

    if (smallest != index) {
        swap(&heap->data[index], &heap->data[smallest]);
        heapifyDown(heap, smallest);
    }
}

void insert(MinHeap* heap, long long value) {
    if (heap->size == heap->capacity) {
        // This case should ideally not be reached if capacity is correctly set
        // to initial numsSize, as each operation reduces the heap size by 1.
        return; 
    }
    heap->data[heap->size] = value;
    heap->size++;
    heapifyUp(heap, heap->size - 1);
}

long long extractMin(MinHeap* heap) {
    if (heap->size == 0) {
        return -1; // Should not happen in a valid problem flow
    }
    long long root = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return root;
}

long long peekMin(MinHeap* heap) {
    if (heap->size == 0) {
        return -1; // Should not happen in a valid problem flow
    }
    return heap->data[0];
}

void freeMinHeap(MinHeap* heap) {
    free(heap->data);
    free(heap);
}

int minOperations(int* nums, int numsSize, int k) {
    MinHeap* heap = createMinHeap(numsSize);

    for (int i = 0; i < numsSize; i++) {
        insert(heap, (long long)nums[i]);
    }

    int operations = 0;

    while (heap->size >= 2 && peekMin(heap) < k) {
        long long x = extractMin(heap);
        long long y = extractMin(heap);

        // As x and y are extracted from a min-heap, x is guaranteed to be min(x,y)
        // and y is max(x,y) (or equal).
        // The problem states: min(x, y) * 2 + max(x, y)
        long long newValue = x * 2 + y; 

        insert(heap, newValue);
        operations++;
    }

    freeMinHeap(heap);
    return operations;
}