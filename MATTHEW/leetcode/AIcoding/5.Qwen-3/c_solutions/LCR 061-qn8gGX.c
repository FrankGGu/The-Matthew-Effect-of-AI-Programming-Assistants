#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int* data;
} Heap;

Heap* createHeap(int capacity) {
    Heap* heap = (Heap*)malloc(sizeof(Heap));
    heap->data = (int*)malloc(capacity * sizeof(int));
    return heap;
}

void push(Heap* heap, int value, int* size) {
    int i = (*size)++;
    while (i > 0) {
        int parent = (i - 1) / 2;
        if (heap->data[parent] <= value) break;
        heap->data[i] = heap->data[parent];
        i = parent;
    }
    heap->data[i] = value;
}

int pop(Heap* heap, int* size) {
    int root = heap->data[0];
    int last = heap->data[--(*size)];
    int i = 0;
    while (i < *size) {
        int left = 2 * i + 1;
        int right = 2 * i + 2;
        int smallest = i;
        if (left < *size && heap->data[left] < heap->data[smallest]) smallest = left;
        if (right < *size && heap->data[right] < heap->data[smallest]) smallest = right;
        if (smallest == i) break;
        heap->data[i] = heap->data[smallest];
        i = smallest;
    }
    heap->data[i] = last;
    return root;
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int** kSmallestPairs(int* nums1, int nums1Size, int* nums2, int nums2Size, int k, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(k * sizeof(int*));
    *returnColumnSizes = (int*)malloc(k * sizeof(int));
    *returnSize = 0;

    if (nums1Size == 0 || nums2Size == 0 || k == 0) return result;

    qsort(nums1, nums1Size, sizeof(int), compare);
    qsort(nums2, nums2Size, sizeof(int), compare);

    Heap* minHeap = createHeap(k);
    int heapSize = 0;

    for (int i = 0; i < nums1Size && i < k; i++) {
        push(minHeap, nums1[i] + nums2[0], &heapSize);
    }

    int index = 0;
    while (*returnSize < k && heapSize > 0) {
        int sum = pop(minHeap, &heapSize);
        int idx1 = sum - nums2[0];
        int idx2 = 0;

        for (int i = 0; i < nums1Size; i++) {
            if (nums1[i] == idx1) {
                idx1 = i;
                break;
            }
        }

        result[*returnSize] = (int*)malloc(2 * sizeof(int));
        result[*returnSize][0] = nums1[idx1];
        result[*returnSize][1] = nums2[idx2];
        (*returnColumnSizes)[*returnSize] = 2;
        (*returnSize)++;

        if (idx2 + 1 < nums2Size) {
            push(minHeap, nums1[idx1] + nums2[idx2 + 1], &heapSize);
        }
    }

    free(minHeap->data);
    free(minHeap);
    return result;
}