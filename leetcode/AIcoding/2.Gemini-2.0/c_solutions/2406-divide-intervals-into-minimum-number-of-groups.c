#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return ((int*)a)[0] - ((int*)b)[0];
}

int minGroups(int** intervals, int intervalsSize, int* intervalsColSize) {
    qsort(intervals, intervalsSize, sizeof(intervals[0]), compare);

    int* heap = (int*)malloc(intervalsSize * sizeof(int));
    int heapSize = 0;

    for (int i = 0; i < intervalsSize; i++) {
        if (heapSize == 0) {
            heap[heapSize++] = intervals[i][1];
        } else {
            int j = 0;
            while (j < heapSize && heap[j] < intervals[i][0]) {
                j++;
            }
            if (j == heapSize) {
                heap[heapSize++] = intervals[i][1];
            } else {
                heap[j] = intervals[i][1];
            }
        }

        int k = heapSize - 1;
        while (k > 0 && heap[k] < heap[k - 1]) {
            int temp = heap[k];
            heap[k] = heap[k - 1];
            heap[k - 1] = temp;
            k--;
        }
    }

    free(heap);
    return heapSize;
}