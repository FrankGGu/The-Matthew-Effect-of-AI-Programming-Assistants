#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int furthestBuilding(int* heights, int heightsSize, int bricks, int ladders) {
    int* minHeap = (int*)malloc(ladders * sizeof(int));
    int heapSize = 0;

    for (int i = 0; i < heightsSize - 1; i++) {
        int diff = heights[i + 1] - heights[i];
        if (diff <= 0) continue;

        if (heapSize < ladders) {
            minHeap[heapSize++] = diff;
            qsort(minHeap, heapSize, sizeof(int), compare);
        } else {
            if (diff < minHeap[0]) {
                minHeap[0] = diff;
                qsort(minHeap, heapSize, sizeof(int), compare);
            } else {
                bricks -= diff;
                if (bricks < 0) {
                    free(minHeap);
                    return i;
                }
            }
        }
    }

    free(minHeap);
    return heightsSize - 1;
}