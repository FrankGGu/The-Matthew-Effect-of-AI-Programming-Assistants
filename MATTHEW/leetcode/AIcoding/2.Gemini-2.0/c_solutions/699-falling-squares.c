#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int start;
    int end;
    int height;
} Interval;

int max(int a, int b) {
    return (a > b) ? a : b;
}

int fallingSquares(int** positions, int positionsSize, int* positionsColSize, int* returnSize) {
    int* heights = (int*)malloc(positionsSize * sizeof(int));
    *returnSize = positionsSize;

    Interval* intervals = (Interval*)malloc(positionsSize * sizeof(Interval));
    int count = 0;

    int maxHeight = 0;

    for (int i = 0; i < positionsSize; i++) {
        int start = positions[i][0];
        int side = positions[i][1];
        int end = start + side;
        int currentHeight = side;

        for (int j = 0; j < count; j++) {
            if (max(start, intervals[j].start) < min(end, intervals[j].end)) {
                currentHeight = max(currentHeight, intervals[j].height + side);
            }
        }

        intervals[count].start = start;
        intervals[count].end = end;
        intervals[count].height = side;
        count++;

        maxHeight = max(maxHeight, currentHeight);
        heights[i] = maxHeight;
    }

    free(intervals);
    return heights;
}