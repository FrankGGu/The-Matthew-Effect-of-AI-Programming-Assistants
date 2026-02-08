#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* data;
    int size;
} Heap;

void swap(int* a, int* b) {
    int t = *a;
    *a = *b;
    *b = t;
}

void heapify(Heap* h, int i) {
    int smallest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < h->size && (h->data[left] < h->data[smallest]))
        smallest = left;
    if (right < h->size && (h->data[right] < h->data[smallest]))
        smallest = right;

    if (smallest != i) {
        swap(&h->data[i], &h->data[smallest]);
        heapify(h, smallest);
    }
}

void push(Heap* h, int val) {
    h->data[h->size++] = val;
    int i = h->size - 1;
    while (i > 0 && h->data[(i - 1) / 2] > h->data[i]) {
        swap(&h->data[i], &h->data[(i - 1) / 2]);
        i = (i - 1) / 2;
    }
}

int pop(Heap* h) {
    if (h->size == 0)
        return -1;
    int root = h->data[0];
    h->data[0] = h->data[--h->size];
    heapify(h, 0);
    return root;
}

int** kSmallestPairs(int* nums1, int nums1Size, int* nums2, int nums2Size, int k, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(k * sizeof(int*));
    *returnColumnSizes = (int*)malloc(k * sizeof(int));
    *returnSize = 0;

    if (nums1Size == 0 || nums2Size == 0 || k == 0)
        return result;

    Heap* minHeap = (Heap*)malloc(sizeof(Heap));
    minHeap->data = (int*)malloc(k * sizeof(int));
    minHeap->size = 0;

    for (int i = 0; i < nums1Size && i < k; i++) {
        minHeap->data[minHeap->size++] = i;
    }

    for (int i = 0; i < k && minHeap->size > 0; i++) {
        int index = pop(minHeap);
        int sum = nums1[index] + nums2[0];
        result[*returnSize] = (int*)malloc(2 * sizeof(int));
        result[*returnSize][0] = nums1[index];
        result[*returnSize][1] = nums2[0];
        (*returnColumnSizes)[*returnSize] = 2;
        (*returnSize)++;
        if (0 < nums2Size - 1) {
            push(minHeap, index);
        }
    }

    free(minHeap->data);
    free(minHeap);

    return result;
}