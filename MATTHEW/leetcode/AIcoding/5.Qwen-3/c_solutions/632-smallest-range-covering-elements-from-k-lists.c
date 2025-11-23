#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int val;
    int list_idx;
    int element_idx;
} Node;

int compare(const void *a, const void *b) {
    return ((Node *)a)->val - ((Node *)b)->val;
}

int* smallestRange(int** lists, int listsSize, int* listsColSize, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = 0;
    result[1] = INT_MAX;

    Node* minHeap = (Node*)malloc(listsSize * sizeof(Node));
    int heapSize = 0;

    for (int i = 0; i < listsSize; i++) {
        minHeap[heapSize].val = lists[i][0];
        minHeap[heapSize].list_idx = i;
        minHeap[heapSize].element_idx = 0;
        heapSize++;
    }

    qsort(minHeap, heapSize, sizeof(Node), compare);

    int current_max = 0;
    for (int i = 0; i < heapSize; i++) {
        if (minHeap[i].val > current_max) {
            current_max = minHeap[i].val;
        }
    }

    while (1) {
        int current_min = minHeap[0].val;
        int list_idx = minHeap[0].list_idx;
        int element_idx = minHeap[0].element_idx;

        if (current_max - current_min < result[1] - result[0]) {
            result[0] = current_min;
            result[1] = current_max;
        }

        if (element_idx + 1 >= listsColSize[list_idx]) {
            break;
        }

        minHeap[0].val = lists[list_idx][element_idx + 1];
        minHeap[0].element_idx += 1;

        qsort(minHeap, heapSize, sizeof(Node), compare);

        if (minHeap[0].val > current_max) {
            current_max = minHeap[0].val;
        }
    }

    *returnSize = 2;
    free(minHeap);
    return result;
}