#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int* heap;
    int size;
} Heap;

void swap(int* a, int* b) {
    int t = *a;
    *a = *b;
    *b = t;
}

void heapify_up(Heap* h, int index) {
    while (index > 0) {
        int parent = (index - 1) / 2;
        if (h->heap[parent] <= h->heap[index]) break;
        swap(&h->heap[parent], &h->heap[index]);
        index = parent;
    }
}

void heapify_down(Heap* h, int index) {
    int min_index = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < h->size && h->heap[left] < h->heap[min_index]) {
        min_index = left;
    }
    if (right < h->size && h->heap[right] < h->heap[min_index]) {
        min_index = right;
    }

    if (min_index != index) {
        swap(&h->heap[index], &h->heap[min_index]);
        heapify_down(h, min_index);
    }
}

void push(Heap* h, int value) {
    h->heap[h->size++] = value;
    heapify_up(h, h->size - 1);
}

int pop(Heap* h) {
    int root = h->heap[0];
    h->heap[0] = h->heap[--h->size];
    heapify_down(h, 0);
    return root;
}

bool is_empty(Heap* h) {
    return h->size == 0;
}

int maxEatenApples(int* apples, int applesSize, int* days, int daysSize) {
    Heap* min_heap = (Heap*)malloc(sizeof(Heap));
    min_heap->heap = (int*)malloc(applesSize * sizeof(int));
    min_heap->size = 0;

    int time = 0;
    int eaten = 0;

    for (int i = 0; i < applesSize; i++) {
        int count = apples[i];
        int expire = time + days[i];

        if (count > 0) {
            push(min_heap, expire);
        }

        while (!is_empty(min_heap) && min_heap->heap[0] <= time) {
            pop(min_heap);
        }

        if (!is_empty(min_heap)) {
            eaten++;
            pop(min_heap);
        }

        time++;
    }

    free(min_heap->heap);
    free(min_heap);

    return eaten;
}