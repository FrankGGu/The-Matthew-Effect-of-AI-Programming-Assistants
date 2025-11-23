#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* heap;
    int size;
    int capacity;
} Heap;

Heap* createHeap(int capacity) {
    Heap* h = (Heap*)malloc(sizeof(Heap));
    h->heap = (int*)malloc((capacity + 1) * sizeof(int));
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
    while (index > 1 && h->heap[index / 2] > h->heap[index]) {
        swap(&h->heap[index / 2], &h->heap[index]);
        index /= 2;
    }
}

void heapifyDown(Heap* h, int index) {
    int smallest = index;
    int left = 2 * index;
    int right = 2 * index + 1;

    if (left <= h->size && h->heap[left] < h->heap[smallest]) {
        smallest = left;
    }

    if (right <= h->size && h->heap[right] < h->heap[smallest]) {
        smallest = right;
    }

    if (smallest != index) {
        swap(&h->heap[index], &h->heap[smallest]);
        heapifyDown(h, smallest);
    }
}

void insert(Heap* h, int value) {
    h->size++;
    h->heap[h->size] = value;
    heapifyUp(h, h->size);
}

int extractMin(Heap* h) {
    int min = h->heap[1];
    h->heap[1] = h->heap[h->size];
    h->size--;
    heapifyDown(h, 1);
    return min;
}

int getMin(Heap* h) {
    return h->heap[1];
}

typedef struct {
    Heap* available;
    int total;
} SeatManager;

SeatManager* seatManagerCreate(int n) {
    SeatManager* sm = (SeatManager*)malloc(sizeof(SeatManager));
    sm->available = createHeap(n);
    for (int i = 1; i <= n; i++) {
        insert(sm->available, i);
    }
    sm->total = n;
    return sm;
}

int seatManagerReserve(SeatManager* obj) {
    return extractMin(obj->available);
}

void seatManagerUnreserve(SeatManager* obj, int seatNumber) {
    insert(obj->available, seatNumber);
}

void seatManagerFree(SeatManager* obj) {
    free(obj->available->heap);
    free(obj->available);
    free(obj);
}