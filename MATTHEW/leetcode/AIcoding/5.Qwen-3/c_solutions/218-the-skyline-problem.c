#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int x;
    int h;
} Point;

typedef struct {
    int* data;
    int size;
    int capacity;
} Heap;

Heap* createHeap(int capacity) {
    Heap* heap = (Heap*)malloc(sizeof(Heap));
    heap->data = (int*)malloc(capacity * sizeof(int));
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

void swap(int* a, int* b) {
    int t = *a;
    *a = *b;
    *b = t;
}

void heapifyUp(Heap* heap, int index) {
    while (index > 0) {
        int parent = (index - 1) / 2;
        if (heap->data[parent] <= heap->data[index]) break;
        swap(&heap->data[parent], &heap->data[index]);
        index = parent;
    }
}

void heapifyDown(Heap* heap, int index) {
    int smallest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < heap->size && heap->data[left] < heap->data[smallest])
        smallest = left;
    if (right < heap->size && heap->data[right] < heap->data[smallest])
        smallest = right;

    if (smallest != index) {
        swap(&heap->data[index], &heap->data[smallest]);
        heapifyDown(heap, smallest);
    }
}

void push(Heap* heap, int value) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2;
        heap->data = (int*)realloc(heap->data, heap->capacity * sizeof(int));
    }
    heap->data[heap->size++] = value;
    heapifyUp(heap, heap->size - 1);
}

int pop(Heap* heap) {
    if (heap->size == 0) return -1;
    int root = heap->data[0];
    heap->data[0] = heap->data[--heap->size];
    heapifyDown(heap, 0);
    return root;
}

int peek(Heap* heap) {
    return heap->size > 0 ? heap->data[0] : -1;
}

void freeHeap(Heap* heap) {
    free(heap->data);
    free(heap);
}

int compare(const void* a, const void* b) {
    Point* p1 = (Point*)a;
    Point* p2 = (Point*)b;
    return p1->x - p2->x;
}

int** getSkyline(int** buildings, int buildingsSize, int* buildingsColSize, int* returnSize) {
    Point* points = (Point*)malloc(buildingsSize * 2 * sizeof(Point));
    int pointCount = 0;

    for (int i = 0; i < buildingsSize; i++) {
        points[pointCount++] = (Point){buildings[i][0], buildings[i][2]};
        points[pointCount++] = (Point){buildings[i][1], -buildings[i][2]};
    }

    qsort(points, pointCount, sizeof(Point), compare);

    int** result = (int**)malloc(buildingsSize * 2 * sizeof(int*));
    *returnSize = 0;

    Heap* maxHeap = createHeap(1);
    push(maxHeap, 0);

    int prevHeight = 0;
    int currHeight = 0;

    for (int i = 0; i < pointCount; i++) {
        int x = points[i].x;
        int h = points[i].h;

        if (h > 0) {
            push(maxHeap, h);
        } else {
            int removeHeight = -h;
            for (int j = 0; j < maxHeap->size; j++) {
                if (maxHeap->data[j] == removeHeight) {
                    maxHeap->data[j] = maxHeap->data[maxHeap->size - 1];
                    maxHeap->size--;
                    heapifyDown(maxHeap, j);
                    break;
                }
            }
        }

        currHeight = peek(maxHeap);

        if (currHeight != prevHeight) {
            result[*returnSize] = (int*)malloc(2 * sizeof(int));
            result[*returnSize][0] = x;
            result[*returnSize][1] = currHeight;
            (*returnSize)++;
            prevHeight = currHeight;
        }
    }

    free(points);
    freeHeap(maxHeap);
    return result;
}