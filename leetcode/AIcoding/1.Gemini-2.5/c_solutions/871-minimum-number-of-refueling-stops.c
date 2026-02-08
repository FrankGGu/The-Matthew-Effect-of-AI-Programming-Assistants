#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int* data;
    int capacity;
    int size;
} MaxHeap;

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void heap_init(MaxHeap* heap, int capacity) {
    heap->data = (int*)malloc(sizeof(int) * capacity);
    heap->capacity = capacity;
    heap->size = 0;
}

void heap_free(MaxHeap* heap) {
    free(heap->data);
    heap->data = NULL;
    heap->capacity = 0;
    heap->size = 0;
}

void heapify_up(MaxHeap* heap, int index) {
    while (index > 0 && heap->data[index] > heap->data[(index - 1) / 2]) {
        swap(&heap->data[index], &heap->data[(index - 1) / 2]);
        index = (index - 1) / 2;
    }
}

void heapify_down(MaxHeap* heap, int index) {
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

void heap_push(MaxHeap* heap, int value) {
    if (heap->size == heap->capacity) {
        return;
    }
    heap->data[heap->size] = value;
    heap->size++;
    heapify_up(heap, heap->size - 1);
}

int heap_pop(MaxHeap* heap) {
    if (heap->size == 0) {
        return -1;
    }
    int root = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapify_down(heap, 0);
    return root;
}

bool heap_is_empty(MaxHeap* heap) {
    return heap->size == 0;
}

int minRefuelStops(int target, int startFuel, int** stations, int stationsSize, int* stationsColSize) {
    MaxHeap heap;
    heap_init(&heap, stationsSize);

    int stops = 0;
    long long currentReach = startFuel;
    int station_idx = 0;

    while (currentReach < target) {
        while (station_idx < stationsSize && stations[station_idx][0] <= currentReach) {
            heap_push(&heap, stations[station_idx][1]);
            station_idx++;
        }

        if (heap_is_empty(&heap)) {
            heap_free(&heap);
            return -1;
        }

        currentReach += heap_pop(&heap);
        stops++;
    }

    heap_free(&heap);
    return stops;
}