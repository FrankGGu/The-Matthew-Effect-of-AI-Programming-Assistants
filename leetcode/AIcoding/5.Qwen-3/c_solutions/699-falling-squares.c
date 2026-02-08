#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int start;
    int end;
    int height;
} Interval;

typedef struct {
    int x1;
    int x2;
    int y;
} Square;

int compare(const void *a, const void *b) {
    return ((Interval *)a)->start - ((Interval *)b)->start;
}

int* fallingSquares(int** positions, int positionsSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * positionsSize);
    int resultIndex = 0;

    Interval* intervals = (Interval*)malloc(sizeof(Interval) * positionsSize);
    int intervalCount = 0;

    for (int i = 0; i < positionsSize; i++) {
        int x = positions[i][0];
        int y = positions[i][1];

        int newStart = x;
        int newEnd = x + y;
        int newHeight = y;

        for (int j = 0; j < intervalCount; j++) {
            if (intervals[j].start < newEnd && intervals[j].end > newStart) {
                newHeight = fmax(newHeight, intervals[j].height + y);
            }
        }

        intervals[intervalCount].start = newStart;
        intervals[intervalCount].end = newEnd;
        intervals[intervalCount].height = newHeight;
        intervalCount++;

        qsort(intervals, intervalCount, sizeof(Interval), compare);

        int maxHeight = 0;
        for (int j = 0; j < intervalCount; j++) {
            maxHeight = fmax(maxHeight, intervals[j].height);
        }

        result[resultIndex++] = maxHeight;
    }

    free(intervals);
    *returnSize = resultIndex;
    return result;
}