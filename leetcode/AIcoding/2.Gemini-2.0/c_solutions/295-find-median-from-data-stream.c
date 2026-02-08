#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *min_heap;
    int min_heap_size;
    int *max_heap;
    int max_heap_size;
    int capacity;
} MedianFinder;

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void min_heapify(int *heap, int i, int heap_size) {
    int smallest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < heap_size && heap[left] < heap[smallest]) {
        smallest = left;
    }

    if (right < heap_size && heap[right] < heap[smallest]) {
        smallest = right;
    }

    if (smallest != i) {
        swap(&heap[i], &heap[smallest]);
        min_heapify(heap, smallest, heap_size);
    }
}

void max_heapify(int *heap, int i, int heap_size) {
    int largest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < heap_size && heap[left] > heap[largest]) {
        largest = left;
    }

    if (right < heap_size && heap[right] > heap[largest]) {
        largest = right;
    }

    if (largest != i) {
        swap(&heap[i], &heap[largest]);
        max_heapify(heap, largest, heap_size);
    }
}

MedianFinder *medianFinderCreate() {
    MedianFinder *obj = (MedianFinder *)malloc(sizeof(MedianFinder));
    obj->capacity = 100000;
    obj->min_heap = (int *)malloc(obj->capacity * sizeof(int));
    obj->max_heap = (int *)malloc(obj->capacity * sizeof(int));
    obj->min_heap_size = 0;
    obj->max_heap_size = 0;
    return obj;
}

void medianFinderAddNum(MedianFinder *obj, int num) {
    if (obj->max_heap_size == 0 || num <= obj->max_heap[0]) {
        obj->max_heap[obj->max_heap_size++] = num;
        int i = obj->max_heap_size - 1;
        while (i > 0 && obj->max_heap[i] > obj->max_heap[(i - 1) / 2]) {
            swap(&obj->max_heap[i], &obj->max_heap[(i - 1) / 2]);
            i = (i - 1) / 2;
        }
    } else {
        obj->min_heap[obj->min_heap_size++] = num;
        int i = obj->min_heap_size - 1;
        while (i > 0 && obj->min_heap[i] < obj->min_heap[(i - 1) / 2]) {
            swap(&obj->min_heap[i], &obj->min_heap[(i - 1) / 2]);
            i = (i - 1) / 2;
        }
    }

    if (obj->max_heap_size > obj->min_heap_size + 1) {
        int temp = obj->max_heap[0];
        obj->max_heap[0] = obj->max_heap[--obj->max_heap_size];
        max_heapify(obj->max_heap, 0, obj->max_heap_size);

        obj->min_heap[obj->min_heap_size++] = temp;
        int i = obj->min_heap_size - 1;
        while (i > 0 && obj->min_heap[i] < obj->min_heap[(i - 1) / 2]) {
            swap(&obj->min_heap[i], &obj->min_heap[(i - 1) / 2]);
            i = (i - 1) / 2;
        }
    } else if (obj->min_heap_size > obj->max_heap_size) {
        int temp = obj->min_heap[0];
        obj->min_heap[0] = obj->min_heap[--obj->min_heap_size];
        min_heapify(obj->min_heap, 0, obj->min_heap_size);

        obj->max_heap[obj->max_heap_size++] = temp;
        int i = obj->max_heap_size - 1;
        while (i > 0 && obj->max_heap[i] > obj->max_heap[(i - 1) / 2]) {
            swap(&obj->max_heap[i], &obj->max_heap[(i - 1) / 2]);
            i = (i - 1) / 2;
        }
    }
}

double medianFinderFindMedian(MedianFinder *obj) {
    if ((obj->max_heap_size + obj->min_heap_size) % 2 == 0) {
        return (double)(obj->max_heap[0] + obj->min_heap[0]) / 2.0;
    } else {
        return (double)obj->max_heap[0];
    }
}

void medianFinderFree(MedianFinder *obj) {
    free(obj->min_heap);
    free(obj->max_heap);
    free(obj);
}