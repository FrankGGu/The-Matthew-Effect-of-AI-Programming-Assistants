#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <math.h>

struct MinHeap {
    int* data;
    int size;
};

struct MinHeap* createMinHeap(int capacity) {
    struct MinHeap* heap = (struct MinHeap*)malloc(sizeof(struct MinHeap));
    heap->data = (int*)malloc(sizeof(int) * capacity);
    heap->size = 0;
    return heap;
}

void insert(struct MinHeap* heap, int value) {
    heap->data[heap->size++] = value;
    int i = heap->size - 1;
    while (i != 0 && heap->data[(i - 1) / 2] > heap->data[i]) {
        int temp = heap->data[i];
        heap->data[i] = heap->data[(i - 1) / 2];
        heap->data[(i - 1) / 2] = temp;
        i = (i - 1) / 2;
    }
}

int extractMin(struct MinHeap* heap) {
    if (heap->size <= 0) return INT_MAX;
    if (heap->size == 1) return heap->data[--heap->size];

    int root = heap->data[0];
    heap->data[0] = heap->data[--heap->size];
    int i = 0;
    while (i < heap->size / 2) {
        int smallest = i, left = 2 * i + 1, right = 2 * i + 2;
        if (left < heap->size && heap->data[left] < heap->data[smallest]) smallest = left;
        if (right < heap->size && heap->data[right] < heap->data[smallest]) smallest = right;
        if (smallest == i) break;
        int temp = heap->data[i];
        heap->data[i] = heap->data[smallest];
        heap->data[smallest] = temp;
        i = smallest;
    }
    return root;
}

int minimumDeviation(int* nums, int numsSize) {
    struct MinHeap* minHeap = createMinHeap(numsSize);
    int maxVal = INT_MIN;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 != 0) nums[i] *= 2;
        insert(minHeap, nums[i]);
        if (nums[i] > maxVal) maxVal = nums[i];
    }

    int minDeviation = INT_MAX;

    while (minHeap->size > 0) {
        int minVal = extractMin(minHeap);
        minDeviation = fmin(minDeviation, maxVal - minVal);
        if (minVal % 2 == 0) {
            minVal /= 2;
            insert(minHeap, minVal);
            if (minVal > maxVal) maxVal = minVal;
        } else {
            break;
        }
    }

    free(minHeap->data);
    free(minHeap);

    return minDeviation;
}