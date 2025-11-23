#include <stdlib.h>

#define MOD 1000000007

typedef struct {
    int* data;
    int size;
    int capacity;
} MinHeap;

int parent(int i) {
    return (i - 1) / 2;
}

int left_child(int i) {
    return 2 * i + 1;
}

int right_child(int i) {
    return 2 * i + 2;
}

MinHeap* createMinHeap(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->data = (int*)malloc(sizeof(int) * capacity);
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

void freeMinHeap(MinHeap* heap) {
    free(heap->data);
    free(heap);
}

void heapifyUp(MinHeap* heap, int i) {
    while (i > 0 && heap->data[parent(i)] > heap->data[i]) {
        int temp = heap->data[i];
        heap->data[i] = heap->data[parent(i)];
        heap->data[parent(i)] = temp;
        i = parent(i);
    }
}

void heapifyDown(MinHeap* heap, int i) {
    int smallest = i;
    int l = left_child(i);
    int r = right_child(i);

    if (l < heap->size && heap->data[l] < heap->data[smallest]) {
        smallest = l;
    }

    if (r < heap->size && heap->data[r] < heap->data[smallest]) {
        smallest = r;
    }

    if (smallest != i) {
        int temp = heap->data[i];
        heap->data[i] = heap->data[smallest];
        heap->data[smallest] = temp;
        heapifyDown(heap, smallest);
    }
}

void insertMinHeap(MinHeap* heap, int val) {
    if (heap->size == heap->capacity) {
        return; 
    }
    heap->data[heap->size] = val;
    heap->size++;
    heapifyUp(heap, heap->size - 1);
}

int extractMin(MinHeap* heap) {
    if (heap->size <= 0) {
        return -1; 
    }
    if (heap->size == 1) {
        heap->size--;
        return heap->data[0];
    }

    int root = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return root;
}

void buildMinHeap(MinHeap* heap, int* nums, int numsSize) {
    for (int i = 0; i < numsSize; i++) {
        heap->data[i] = nums[i];
    }
    heap->size = numsSize;

    for (int i = (heap->size / 2) - 1; i >= 0; i--) {
        heapifyDown(heap, i);
    }
}

long long maximumProduct(int* nums, int numsSize, int k) {
    MinHeap* heap = createMinHeap(numsSize);
    buildMinHeap(heap, nums, numsSize);

    for (int i = 0; i < k; i++) {
        int minVal = extractMin(heap);
        insertMinHeap(heap, minVal + 1);
    }

    long long product = 1;
    for (int i = 0; i < heap->size; i++) {
        product = (product * heap->data[i]) % MOD;
    }

    freeMinHeap(heap);
    return product;
}