#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* heap;
    int size;
    int capacity;
} Heap;

Heap* createHeap(int capacity) {
    Heap* h = (Heap*)malloc(sizeof(Heap));
    h->heap = (int*)malloc(capacity * sizeof(int));
    h->size = 0;
    h->capacity = capacity;
    return h;
}

void swap(int* a, int* b) {
    int t = *a;
    *a = *b;
    *b = t;
}

void heapifyUp(Heap* h, int index) {
    while (index > 0) {
        int parent = (index - 1) / 2;
        if (h->heap[parent] <= h->heap[index]) break;
        swap(&h->heap[parent], &h->heap[index]);
        index = parent;
    }
}

void heapifyDown(Heap* h, int index) {
    int smallest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < h->size && h->heap[left] < h->heap[smallest]) smallest = left;
    if (right < h->size && h->heap[right] < h->heap[smallest]) smallest = right;

    if (smallest != index) {
        swap(&h->heap[index], &h->heap[smallest]);
        heapifyDown(h, smallest);
    }
}

void push(Heap* h, int value) {
    if (h->size == h->capacity) {
        h->capacity *= 2;
        h->heap = (int*)realloc(h->heap, h->capacity * sizeof(int));
    }
    h->heap[h->size++] = value;
    heapifyUp(h, h->size - 1);
}

int pop(Heap* h) {
    if (h->size == 0) return -1;
    int root = h->heap[0];
    h->heap[0] = h->heap[--h->size];
    heapifyDown(h, 0);
    return root;
}

void freeHeap(Heap* h) {
    free(h->heap);
    free(h);
}

long long totalCostToHireKWorkers(int* costs, int costsSize, int k) {
    Heap* minHeap1 = createHeap(costsSize);
    Heap* minHeap2 = createHeap(costsSize);

    for (int i = 0; i < costsSize; i++) {
        push(minHeap1, costs[i]);
    }

    long long totalCost = 0;
    int count = 0;

    while (count < k) {
        int cost1 = pop(minHeap1);
        int cost2 = (minHeap2->size > 0) ? pop(minHeap2) : INT_MAX;

        if (cost1 <= cost2) {
            totalCost += cost1;
            push(minHeap2, cost1);
        } else {
            totalCost += cost2;
            push(minHeap2, cost2);
        }

        count++;
    }

    freeHeap(minHeap1);
    freeHeap(minHeap2);

    return totalCost;
}