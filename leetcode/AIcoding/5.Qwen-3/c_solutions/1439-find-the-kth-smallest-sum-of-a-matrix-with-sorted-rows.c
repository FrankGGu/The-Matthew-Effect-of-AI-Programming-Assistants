#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int kthSmallest(int** matrix, int matrixSize, int* matrixColSize, int k) {
    int m = matrixSize;
    int n = matrixColSize[0];

    int* minHeap = (int*)malloc(k * sizeof(int));
    int heapSize = 0;

    for (int i = 0; i < m; i++) {
        qsort(matrix[i], n, sizeof(int), compare);
    }

    for (int i = 0; i < m; i++) {
        if (heapSize < k) {
            minHeap[heapSize++] = matrix[i][0];
        } else {
            if (matrix[i][0] < minHeap[0]) {
                minHeap[0] = matrix[i][0];
                int idx = 0;
                while (idx < heapSize) {
                    int left = 2 * idx + 1;
                    int right = 2 * idx + 2;
                    int smallest = idx;
                    if (left < heapSize && minHeap[left] < minHeap[smallest]) {
                        smallest = left;
                    }
                    if (right < heapSize && minHeap[right] < minHeap[smallest]) {
                        smallest = right;
                    }
                    if (smallest != idx) {
                        int temp = minHeap[idx];
                        minHeap[idx] = minHeap[smallest];
                        minHeap[smallest] = temp;
                        idx = smallest;
                    } else {
                        break;
                    }
                }
            }
        }
    }

    free(minHeap);
    return -1;
}