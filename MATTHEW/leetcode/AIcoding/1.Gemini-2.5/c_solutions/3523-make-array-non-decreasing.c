#include <stdlib.h> // For malloc, free, realloc

typedef struct {
    int* data;
    int capacity;
    int size;
} MinHeap;

MinHeap* createMinHeap(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->data = (int*)malloc(sizeof(int) * capacity);
    heap->capacity = capacity;
    heap->size = 0;
    return heap;
}

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(MinHeap* heap, int index) {
    int parent = (index - 1) / 2;
    while (index > 0 && heap->data[parent] > heap->data[index]) {
        swap(&heap->data[parent], &heap->data[index]);
        index = parent;
        parent = (index - 1) / 2;
    }
}

void heapifyDown(MinHeap* heap, int index) {
    int smallest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < heap->size && heap->data[left] < heap->data[smallest]) {
        smallest = left;
    }
    if (right < heap->size && heap->data[right] < heap->data[smallest]) {
        smallest = right;
    }

    if (smallest != index) {
        swap(&heap->data[index], &heap->data[smallest]);
        heapifyDown(heap, smallest);
    }
}

void insertMinHeap(MinHeap* heap, int value) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2; // Double capacity
        heap->data = (int*)realloc(heap->data, sizeof(int) * heap->capacity);
    }
    heap->data[heap->size] = value;
    heapifyUp(heap, heap->size);
    heap->size++;
}

int extractMin(MinHeap* heap) {
    if (heap->size <= 0) {
        return 0; // Should not be called on an empty heap in this problem's logic
    }
    int root = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return root;
}

int peekMin(MinHeap* heap) {
    if (heap->size <= 0) {
        return 0; // Should not be called on an empty heap in this problem's logic
    }
    return heap->data[0];
}

void freeMinHeap(MinHeap* heap) {
    free(heap->data);
    free(heap);
}

long long makeArrayNonDecreasing(int* nums, int numsSize) {
    // We use a min-heap to simulate a max-heap by storing negative values.
    // The smallest negative value in the min-heap corresponds to the largest positive value.
    MinHeap* pq = createMinHeap(numsSize > 0 ? numsSize : 1); // Initial capacity

    long long cost = 0;

    for (int i = 0; i < numsSize; i++) {
        // If the current number `nums[i]` is smaller than the largest element
        // we've committed to for the non-decreasing sequence (which is -peekMin(pq)):
        if (pq->size > 0 && nums[i] < -peekMin(pq)) {
            // We must change the largest element in our sequence to `nums[i]`
            // to satisfy the non-decreasing property and minimize cost.
            // The cost incurred is the difference: (largest element) - nums[i].
            cost += (long long)(-peekMin(pq) - nums[i]);

            // Remove the old largest element (smallest negative value)
            extractMin(pq);

            // Add `nums[i]` (as negative) back to the heap. This replaces the element that was too large.
            insertMinHeap(pq, -nums[i]);
        }
        // Always add `nums[i]` (as negative) to the heap. This accounts for the current element.
        insertMinHeap(pq, -nums[i]);
    }

    freeMinHeap(pq);
    return cost;
}