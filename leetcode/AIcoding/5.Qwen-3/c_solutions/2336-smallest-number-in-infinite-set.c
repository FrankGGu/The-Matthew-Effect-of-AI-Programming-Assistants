#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* heap;
    int size;
    int capacity;
} Solution;

Solution* solutionCreate() {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->heap = (int*)malloc(sizeof(int) * 100);
    obj->size = 0;
    obj->capacity = 100;
    return obj;
}

void heapify(Solution* obj, int i) {
    int smallest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < obj->size && obj->heap[left] < obj->heap[smallest]) {
        smallest = left;
    }
    if (right < obj->size && obj->heap[right] < obj->heap[smallest]) {
        smallest = right;
    }
    if (smallest != i) {
        int temp = obj->heap[i];
        obj->heap[i] = obj->heap[smallest];
        obj->heap[smallest] = temp;
        heapify(obj, smallest);
    }
}

void insert(Solution* obj, int val) {
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->heap = (int*)realloc(obj->heap, sizeof(int) * obj->capacity);
    }
    obj->heap[obj->size++] = val;
    int i = obj->size - 1;
    while (i > 0) {
        int parent = (i - 1) / 2;
        if (obj->heap[parent] <= obj->heap[i]) break;
        int temp = obj->heap[parent];
        obj->heap[parent] = obj->heap[i];
        obj->heap[i] = temp;
        i = parent;
    }
}

int extractMin(Solution* obj) {
    if (obj->size == 0) return -1;
    int min = obj->heap[0];
    obj->heap[0] = obj->heap[--obj->size];
    heapify(obj, 0);
    return min;
}

int getFirst(Solution* obj) {
    return obj->size > 0 ? obj->heap[0] : -1;
}

void solutionFree(Solution* obj) {
    free(obj->heap);
    free(obj);
}

int getMin(Solution* obj) {
    return getFirst(obj);
}

void addBack(Solution* obj, int num) {
    insert(obj, num);
}